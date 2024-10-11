import 'dart:io';

import 'package:flutter_awesome_logger/src/singletones/flutter_log_singleton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpClientProxyWrapper {
  HttpClient? _httpClient;
  final Stream<String> proxyUpdateStream;
  final FlutterLogSingleton loggerSingleton;
  late SharedPreferences _sharedPreferences;
  HttpClient? _initialClient;

  HttpClientProxyWrapper(
    this.proxyUpdateStream,
    this.loggerSingleton,
  ) {
    proxyUpdateStream.listen(
      (event) {
        _recreateClient();
      },
    );
  }

  init(HttpClient httpClient) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    final proxy = _sharedPreferences.getString(proxyName);

    _initialClient = httpClient;
    _httpClient = _initialClient;
    if ((proxy?.isNotEmpty ?? false) &&
        loggerSingleton.loggerSettings.enabled) {
      _httpClient?.findProxy = (_) => "PROXY $proxy;";
      _httpClient?.badCertificateCallback = (_, __, ___) => true;
    }
  }

  _recreateClient() {
    final proxy = _sharedPreferences.getString(proxyName);

    _httpClient = _initialClient;
    if ((proxy?.isNotEmpty ?? false) &&
        loggerSingleton.loggerSettings.enabled) {
      _httpClient?.findProxy = (_) => "PROXY $proxy;";
      _httpClient?.badCertificateCallback = (_, __, ___) => true;
    }
  }

  HttpClient get httpClient {
    if (_httpClient != null) {
      return _httpClient!;
    }
    throw Exception(
      'HttpClient has not been initialized. Be sure to call DioClientWrapper.init() before accessing this it',
    );
  }
}

const proxyName = 'FLUTTER_LOGGER_PROXY';
