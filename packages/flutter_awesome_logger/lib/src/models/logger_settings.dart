import 'dart:io';

import 'package:flutter/foundation.dart';

class LoggerSettings {
  /// When this value is provided logger can work not only when kDebugMode is true.
  /// This is required to use this service on iOS, as TestFlight version is not
  /// on debug mode.
  final bool customWorkingCondition;
  final VoidCallback? onLog;
  final VoidCallback? onHttpLog;

  /// Http client with provided settings that will be used instead of default one.
  final HttpClient? httpClient;

  LoggerSettings({
    this.customWorkingCondition = false,
    this.onLog,
    this.onHttpLog,
    this.httpClient,
  });

  LoggerSettings copyWith({
    bool? customWorkingCondition,
    VoidCallback? onLog,
    VoidCallback? onHttpLog,
    HttpClient? httpClient,
  }) =>
      LoggerSettings(
        customWorkingCondition:
            customWorkingCondition ?? this.customWorkingCondition,
        onLog: onLog ?? this.onLog,
        onHttpLog: onHttpLog ?? this.onHttpLog,
        httpClient: httpClient ?? this.httpClient,
      );

  @override
  bool operator ==(Object other) =>
      other is LoggerSettings &&
      customWorkingCondition == other.customWorkingCondition &&
      onLog == other.onLog &&
      onHttpLog == other.onHttpLog &&
      httpClient == other.httpClient;

  @override
  int get hashCode => Object.hash(
        customWorkingCondition,
        onLog,
        onHttpLog,
        httpClient,
      );
}
