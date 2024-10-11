import 'dart:io';

import 'package:flutter_awesome_logger/src/singletones/flutter_log_singleton.dart';
import 'package:flutter_awesome_logger/src/singletones/proxy_stream_singleton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpWrapperSingleton {
  HttpClient? _httpClient;
  late FlutterLogSingleton _loggerSingleton;
  late SharedPreferences _sharedPreferences;
  HttpClient? _initialClient;

  factory HttpWrapperSingleton() {
    return _instance;
  }

  static final HttpWrapperSingleton _instance =
      HttpWrapperSingleton._internal();

  HttpWrapperSingleton._internal();

  init(HttpClient httpClient) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    final proxy = _sharedPreferences.getString(proxyName);
    _loggerSingleton = FlutterLogSingleton();

    ProxyStreamSingleton().proxyStream.stream.listen(
      (event) {
        _recreateClient();
      },
    );
    _initialClient = httpClient;
    _httpClient = _initialClient;
    if ((proxy?.isNotEmpty ?? false) &&
        _loggerSingleton.loggerSettings.enabled) {
      _httpClient?.findProxy = (_) => "PROXY $proxy;";
      _httpClient?.badCertificateCallback = (_, __, ___) => true;
    }
  }

  _recreateClient() {
    final proxy = _sharedPreferences.getString(proxyName);

    _httpClient = _initialClient;
    if ((proxy?.isNotEmpty ?? false) &&
        _loggerSingleton.loggerSettings.enabled) {
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
