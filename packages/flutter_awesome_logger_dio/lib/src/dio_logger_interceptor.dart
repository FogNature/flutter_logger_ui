import 'package:dio/dio.dart';
import 'package:flutter_awesome_logger/flutter_awesome_logger.dart';
import 'package:flutter_awesome_logger_dio/src/log_request.dart';

class DioLoggerInterceptor extends Interceptor {
  final FlutterLogSingleton loggerSingleton;

  DioLoggerInterceptor(this.loggerSingleton);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final timestamp = logRequest(options);
    final newOptions = options.copyWith(headers: {
      ...options.headers,
      'X-Local-Request-Send-Timestamp': timestamp,
    });
    super.onRequest(newOptions, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final timestamp = int.tryParse(
          response.requestOptions.headers['X-Local-Request-Send-Timestamp']
              .toString(),
        ) ??
        -1;

    updateRequest(response, timestamp, null);

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final timestamp = int.tryParse(
          err.requestOptions.headers['X-Local-Request-Send-Timestamp']
              .toString(),
        ) ??
        -1;

    if (err.response != null) {
      updateRequest(
        err.response!,
        timestamp,
        err.toString(),
      );
    }

    super.onError(err, handler);
  }
}
