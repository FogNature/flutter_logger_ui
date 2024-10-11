import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_awesome_logger/flutter_awesome_logger.dart';
import 'package:flutter_awesome_logger_dio/src/dio_logger_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClientWrapperSingleton {
  Dio? _dio;
  late FlutterLogSingleton _loggerSingleton;
  late SharedPreferences _sharedPreferences;
  Dio? _initialDio;

  factory DioClientWrapperSingleton() {
    return _instance;
  }

  static final DioClientWrapperSingleton _instance =
      DioClientWrapperSingleton._internal();

  DioClientWrapperSingleton._internal();

  init(Dio? dio) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _loggerSingleton = FlutterLogSingleton();
    ProxyStreamSingleton().proxyStream.stream.listen(
      (event) {
        _recreateDio();
      },
    );
    final proxy = _sharedPreferences.getString(proxyName);

    _initialDio = dio ?? Dio();
    _dio = _initialDio;
    if ((proxy?.isNotEmpty ?? false) &&
        _loggerSingleton.loggerSettings.enabled) {
      (_dio?.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        final client = HttpClient();
        client.findProxy = (_) => "PROXY $proxy;";
        client.badCertificateCallback = (_, __, ___) => true;
        return client;
      };
    }
    _dio!.interceptors.add(
      DioLoggerInterceptor(_loggerSingleton),
    );
  }

  _recreateDio() {
    final proxy = _sharedPreferences.getString(proxyName);

    _dio = _initialDio;
    if ((proxy?.isNotEmpty ?? false) &&
        _loggerSingleton.loggerSettings.enabled) {
      (_dio?.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        final client = HttpClient();
        client.findProxy = (_) => "PROXY $proxy;";
        client.badCertificateCallback = (_, __, ___) => true;
        return client;
      };
    }
    _dio!.interceptors.add(
      DioLoggerInterceptor(_loggerSingleton),
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
