import 'package:flutter_awesome_logger/src/services/database/database.dart';

class HttpLogEntry {
  final int id;
  final String method;
  final String path;
  final int? status;
  final String? body;
  final String headers;
  final String query;
  final String? response;
  final String? error;
  final DateTime createdAt;

  HttpLogEntry({
    required this.id,
    required this.method,
    required this.path,
    required this.status,
    required this.body,
    required this.headers,
    required this.query,
    required this.response,
    required this.error,
    required this.createdAt,
  });

  factory HttpLogEntry.fromTableData(HttpLogData data) => HttpLogEntry(
        id: data.id,
        method: data.method,
        path: data.path,
        status: data.status,
        body: data.body,
        headers: data.headers,
        query: data.query,
        response: data.response,
        error: data.error,
        createdAt: data.createdAt,
      );

  @override
  String toString() {
    return 'HttpLogEntry(id: $id, method: $method, path: $path, status: $status, body: $body, headers: $headers, query: $query, response: $response, error: $error, createdAt: $createdAt, )';
  }

  @override
  bool operator ==(Object other) =>
      other is HttpLogEntry &&
      id == other.id &&
      method == other.method &&
      path == other.path &&
      status == other.status &&
      body == other.body &&
      headers == other.headers &&
      query == other.query &&
      response == other.response &&
      error == other.error &&
      createdAt == other.createdAt;

  HttpLogEntry copyWith({
    int? id,
    String? method,
    String? path,
    int? status,
    String? body,
    String? headers,
    String? query,
    String? response,
    String? error,
    DateTime? createdAt,
  }) =>
      HttpLogEntry(
        id: id ?? this.id,
        method: method ?? this.method,
        path: path ?? this.path,
        status: status ?? this.status,
        body: body ?? this.body,
        headers: headers ?? this.headers,
        query: query ?? this.query,
        response: response ?? this.response,
        error: error ?? this.error,
        createdAt: createdAt ?? this.createdAt,
      );

  @override
  int get hashCode => Object.hash(
        id,
        method,
        path,
        status,
        body,
        headers,
        query,
        response,
        error,
        createdAt,
      );
}
