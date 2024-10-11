import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_awesome_logger/flutter_awesome_logger.dart';
import 'package:flutter_awesome_logger_dio/src/dio_logger_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClientWrapper {
  Dio? _dio;
  final Stream<String> proxyUpdateStream;
  final FlutterLogSingleton loggerSingleton;
  late SharedPreferences _sharedPreferences;
  Dio? _initialDio;

  DioClientWrapper(
    this.proxyUpdateStream,
    this.loggerSingleton,
  ) {
    proxyUpdateStream.listen(
      (event) {
        _recreateDio();
      },
    );
  }

  init(Dio? dio) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    final proxy = _sharedPreferences.getString(proxyName);

    _initialDio = dio ?? Dio();
    _dio = _initialDio;
    if ((proxy?.isNotEmpty ?? false) &&
        loggerSingleton.loggerSettings.enabled) {
      (_dio?.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        final client = HttpClient();
        client.findProxy = (_) => "PROXY $proxy;";
        client.badCertificateCallback = (_, __, ___) => true;
        return client;
      };
    }
    _dio!.interceptors.add(
      DioLoggerInterceptor(loggerSingleton),
    );
  }

  _recreateDio() {
    final proxy = _sharedPreferences.getString(proxyName);

    _dio = _initialDio;
    if ((proxy?.isNotEmpty ?? false) &&
        loggerSingleton.loggerSettings.enabled) {
      (_dio?.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        final client = HttpClient();
        client.findProxy = (_) => "PROXY $proxy;";
        client.badCertificateCallback = (_, __, ___) => true;
        return client;
      };
    }
    _dio!.interceptors.add(
      DioLoggerInterceptor(loggerSingleton),
    );
  }

  Dio get dio {
    if (_dio != null) {
      return _dio!;
    }
    throw Exception(
      'Dio has not been initialized. Be sure to call DioClientWrapper.init() before accessing this it',
    );
  }
}

const proxyName = 'FLUTTER_LOGGER_PROXY';
