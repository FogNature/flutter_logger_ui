import 'package:flutter_awesome_logger/flutter_awesome_logger.dart';

class HttpLogEntry {
  final String method;
  final String path;
  final String baseUrl;
  final DateTime createdAt;
  final String? body;
  final int status;
  final String headers;
  final String query;
  final String? response;
  final String? error;
  final DateTime? responseTime;

  HttpLogEntry({
    required this.method,
    required this.path,
    required this.baseUrl,
    required this.createdAt,
    this.body,
    this.status = HttpStatusCodeConstants.pending,
    this.headers = '{}',
    this.query = '{}',
    this.response,
    this.error,
    this.responseTime,
  });

  @override
  String toString() {
    return 'HttpLogEntry(method: $method, path: $path, baseUrl: $baseUrl, createdAt: $createdAt, body: $body, status: $status, headers: $headers, query: $query, response: $response, error: $error,responseTime: $responseTime)';
  }

  @override
  bool operator ==(Object other) =>
      other is HttpLogEntry &&
      method == other.method &&
      path == other.path &&
      baseUrl == other.baseUrl &&
      createdAt == other.createdAt &&
      body == other.body &&
      status == other.status &&
      headers == other.headers &&
      query == other.query &&
      response == other.response &&
      error == other.error &&
      responseTime == other.responseTime;

  HttpLogEntry copyWith({
    String? method,
    String? path,
    String? baseUrl,
    DateTime? createdAt,
    String? body,
    int? status,
    String? headers,
    String? query,
    String? response,
    String? error,
    DateTime? responseTime,
  }) =>
      HttpLogEntry(
        method: method ?? this.method,
        path: path ?? this.path,
        baseUrl: baseUrl ?? this.baseUrl,
        createdAt: createdAt ?? this.createdAt,
        body: body ?? this.body,
        status: status ?? this.status,
        headers: headers ?? this.headers,
        query: query ?? this.query,
        response: response ?? this.response,
        error: error ?? this.error,
        responseTime: responseTime ?? this.responseTime,
      );

  @override
  int get hashCode => Object.hash(
        method,
        path,
        baseUrl,
        createdAt,
        body,
        status,
        headers,
        query,
        response,
        error,
        responseTime,
      );
}
