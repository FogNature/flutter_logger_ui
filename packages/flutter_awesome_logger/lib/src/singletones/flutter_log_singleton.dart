import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter_awesome_logger/src/models/logger_settings.dart';
import 'package:http/http.dart';
import 'package:drift/drift.dart';
import 'package:flutter_awesome_logger/src/models/http_log.dart';
import 'package:flutter_awesome_logger/src/models/log.dart';
import 'package:flutter_awesome_logger/src/services/database/database.dart';
import 'package:flutter_awesome_logger/src/services/database/database_interface.dart';

class FlutterLogSingleton {
  late IPackageDatabase _database;
  late LoggerSettings _loggerSettings;

  FlutterLogSingleton._internal();

  static final FlutterLogSingleton _instance = FlutterLogSingleton._internal();

  static FlutterLogSingleton get instance => _instance;

  void init({
    required IPackageDatabase database,
    required LoggerSettings loggerSettings,
  }) {
    _database = database;
    _loggerSettings = loggerSettings;
  }

  Future<void> addLog({
    required LogLever logLevel,
    required String tag,
    required String info,
  }) async {
    if (_loggerSettings.onHttpLog != null) {
      _loggerSettings.onHttpLog!();
    } else {
      print('=================${logLevel.name.toUpperCase()}=================');
      print('Tag: ${tag}');
      print(info);
      print(
        '=================${'=' * logLevel.name.toUpperCase().length}=================',
      );
    }
    await _database.addLog(
      LoggerDataClassCompanion(
        logLever: Value(logLevel.index),
        createdAt: Value(DateTime.now()),
        tag: Value(tag),
        info: Value(info),
      ),
    );
  }

  Future<List<LogEntry>> getLogs(
    int page,
    LogLever? logLever,
    String? tag,
    String? search,
  ) async {
    final logs = await _database.getLogs(
      logLevel: logLever?.index,
      tag: tag,
      search: search,
      page: page,
    );

    return logs.map(LogEntry.fromTableData).toList();
  }

  Future<void> addHttpLog({
    required String method,
    required String path,
    required int status,
    required String? body,
    required String headers,
    required String query,
    required String? response,
    required String? error,
  }) async {
    if (!_loggerSettings.customWorkingCondition && !kDebugMode) {
      return;
    }
    if (_loggerSettings.onHttpLog != null) {
      _loggerSettings.onHttpLog!();
    } else {
      print('=================REQUEST=================');
      print("$method $path");
      if (headers.isNotEmpty && headers != '{}') {
        print('Headers: $headers');
      }
      if (query.isNotEmpty && query != '{}') {
        print('Query: $query');
      }
      if (body != null) {
        print('Body: $body');
      }
      print('=========================================\n');
      print('=================RESPONSE=================');
      print('Status: $status');
      if (response != null) {
        print('Body: $response');
      }
      if (error != null) {
        print('Error: $error');
      }
      print('==========================================');
    }
    await _database.addHttpLog(
      HttpLoggerDataClassCompanion(
        method: Value(method),
        path: Value(path),
        status: Value(status),
        body: Value(body),
        headers: Value(headers),
        query: Value(query),
        response: Value(response),
        error: Value(error),
        createdAt: Value(DateTime.now()),
      ),
    );
  }

  Future<List<HttpLogEntry>> getHttpLogs(
    int page,
    String? path,
    int? status,
    String? method,
  ) async {
    final httpLogs = await _database.getHttpLogs(
      path: path,
      status: status,
      method: method,
      page: page,
    );

    return httpLogs.map(HttpLogEntry.fromTableData).toList();
  }
}

log(
  String info, {
  LogLever logLevel = LogLever.info,
  String tag = 'INFO',
}) {
  // Move to DB isolate
  FlutterLogSingleton.instance.addLog(
    logLevel: logLevel,
    tag: tag,
    info: info,
  );
}

httpLog(
  Response response,
) {
  final request = response.request;
  if (request is Request) {
    // Move to DB isolate
    FlutterLogSingleton.instance.addHttpLog(
      method: request.method,
      path: request.url.path,
      status: response.statusCode,
      body: request.body,
      headers: request.headers.toString(),
      query: request.url.query,
      response: response.body,
      error: jsonDecode(response.body)?['error'],
    );
  }
}
