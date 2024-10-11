import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_awesome_logger/flutter_awesome_logger.dart';

int logRequest(
  RequestOptions options,
) {
  final dt = DateTime.now();

  final uri = Uri.parse(options.path);
  return FlutterLogSingleton.instance.logHttpRequest(
    method: options.method,
    baseUrl: uri.origin,
    path: uri.path,
    createdAt: dt,
    headers: jsonEncode(options.headers),
    query: jsonEncode(options.queryParameters),
    body: jsonEncode(options.data),
  );
}

void updateRequest(
  Response response,
  int timestamp,
  String? error,
) {
  FlutterLogSingleton.instance.updateHttpLog(
    status: response.statusCode ?? HttpStatusCodeConstants.other,
    response: jsonEncode(response.data),
    error: error,
    createdAt: timestamp,
    responseTime: DateTime.now(),
  );
}
