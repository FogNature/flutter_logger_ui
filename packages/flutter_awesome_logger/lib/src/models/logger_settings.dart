import 'package:flutter/foundation.dart';

class LoggerSettings {
  /// When this value is provided logger can work not only when kDebugMode is true.
  /// This is required to use this service on iOS, as TestFlight version is not
  /// on debug mode.
  final bool enabled;
  final VoidCallback? onLog;
  final VoidCallback? onHttpLog;
  final VoidCallback? onHttpResponse;

  LoggerSettings({
    this.enabled = false,
    this.onLog,
    this.onHttpLog,
    this.onHttpResponse,
  });

  LoggerSettings copyWith({
    bool? enabled,
    VoidCallback? onLog,
    VoidCallback? onHttpLog,
    VoidCallback? onHttpResponse,
  }) =>
      LoggerSettings(
        enabled: enabled ?? this.enabled,
        onLog: onLog ?? this.onLog,
        onHttpLog: onHttpLog ?? this.onHttpLog,
        onHttpResponse: onHttpResponse ?? this.onHttpResponse,
      );

  @override
  bool operator ==(Object other) =>
      other is LoggerSettings &&
      enabled == other.enabled &&
      onLog == other.onLog &&
      onHttpLog == other.onHttpLog &&
      onHttpResponse == other.onHttpResponse;

  @override
  int get hashCode => Object.hash(
        enabled,
        onLog,
        onHttpLog,
        onHttpResponse,
      );
}
