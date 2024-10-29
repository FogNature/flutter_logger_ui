import 'dart:async';

import 'package:flutter_awesome_logger/src/models/log_type.dart';
import 'package:flutter_awesome_logger/src/models/logger_settings.dart';
import 'package:flutter_awesome_logger/src/models/http_log.dart';
import 'package:flutter_awesome_logger/src/models/log.dart';

class FlutterLogSingleton {
  FlutterLogSingleton._internal();

  static final FlutterLogSingleton _instance = FlutterLogSingleton._internal();

  factory FlutterLogSingleton() {
    return _instance;
  }
  List<LogEntry> logs = [];
  List<HttpLogEntry> httpLogs = [];

  late LoggerSettings loggerSettings;
  late StreamController<bool> updateStream;

  void init({
    required LoggerSettings settings,
  }) {
    loggerSettings = settings;
    updateStream = StreamController<bool>.broadcast();
  }

  Future<void> log(
    String info, {
    String? tag,
    LogType? logType,
    String? stackTrace,
  }) async {
    if (!loggerSettings.enabled) {
      return;
    }
    print(
        '=================${(logType ?? LogType.none).name.toUpperCase()}=================');
    print('Tag: ${tag}');
    print(info);
    print(
      '=================${'=' * (logType ?? LogType.none).name.length}=================',
    );
    logs = [
      LogEntry(
        info: info,
        createdAt: DateTime.now(),
        logType: logType ?? LogType.none,
        stackTrace: stackTrace,
      ),
      ...logs,
    ];
    updateStream.add(true);
  }

  int logHttpRequest({
    required String method,
    required String path,
    required String baseUrl,
    required DateTime createdAt,
    required String? headers,
    required String? query,
    required String? body,
  }) {
    if (!loggerSettings.enabled) {
      return -1;
    }
    if (loggerSettings.onHttpLog != null) {
      loggerSettings.onHttpLog!();
    } else {
      print('=================REQUEST=================');
      print("$method $path");
      if ((headers?.isNotEmpty ?? false) && headers != '{}') {
        print('Headers: $headers');
      }
      if ((query?.isNotEmpty ?? false) && query != '{}') {
        print('Query: $query');
      }
      if (body != null) {
        print('Body: $body');
      }
      print('=========================================\n');
    }
    httpLogs = [
      HttpLogEntry(
        method: method,
        baseUrl: baseUrl,
        path: path,
        createdAt: createdAt,
        headers: headers ?? '{}',
        query: query ?? '{}',
        body: body,
      ),
      ...httpLogs,
    ];
    updateStream.add(true);

    return createdAt.millisecondsSinceEpoch;
  }

  void updateHttpLog({
    required String? response,
    required String? error,
    required int? status,
    required int createdAt,
    required DateTime responseTime,
  }) {
    if (!loggerSettings.enabled) {
      return;
    }
    if (loggerSettings.onHttpResponse != null) {
      loggerSettings.onHttpResponse!();
    } else {
      final request = httpLogs.where(
        (element) => element.createdAt.millisecondsSinceEpoch == createdAt,
      );
      print('=================RESPONSE=================');
      if (request.isNotEmpty) {
        print("${request.first.method} ${request.first.path}");
      }
      print('Status: $status');
      if (response != null) {
        print('Body: $response');
      }
      if (error != null) {
        print('Error: $error');
      }
      print('==========================================');
    }
    try {
      httpLogs = httpLogs
          .map(
            (e) => e.createdAt.millisecondsSinceEpoch == createdAt
                ? e.copyWith(
                    status: status,
                    response: response,
                    error: error,
                    responseTime: responseTime,
                  )
                : e,
          )
          .toList();
      updateStream.add(true);
    } catch (e, st) {
      log(
        e.toString(),
        tag: 'HttpLogError',
        logType: LogType.error,
        stackTrace: st.toString(),
      );
    }
  }
}

log(
  String info, {
  LogType? logType,
  String? tag,
  String? stackTrace,
}) {
  FlutterLogSingleton().log(
    info,
    logType: logType,
    tag: tag ?? '',
    stackTrace: stackTrace,
  );
}
