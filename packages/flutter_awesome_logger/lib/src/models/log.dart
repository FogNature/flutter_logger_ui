enum LogType {
  none,
  flutter,
  custom,
  error,
}

class LogEntry {
  final String info;
  final String? tag;
  final LogType logType;
  final DateTime createdAt;
  final String? stackTrace;

  LogEntry({
    required this.info,
    required this.createdAt,
    this.tag,
    this.logType = LogType.none,
    this.stackTrace,
  });

  @override
  String toString() {
    return 'LogEntry(info: $info, tag: $tag, logType: $logType, createdAt: $createdAt, stackTrace: $stackTrace,)';
  }

  @override
  bool operator ==(Object other) =>
      other is LogEntry &&
      info == other.info &&
      tag == other.tag &&
      logType == other.logType &&
      createdAt == other.createdAt &&
      stackTrace == other.stackTrace;

  LogEntry copyWith({
    String? info,
    String? tag,
    LogType? logType,
    DateTime? createdAt,
    String? stackTrace,
  }) =>
      LogEntry(
        info: info ?? this.info,
        tag: tag ?? this.tag,
        logType: logType ?? this.logType,
        createdAt: createdAt ?? this.createdAt,
        stackTrace: stackTrace ?? this.stackTrace,
      );

  @override
  int get hashCode => Object.hash(
        info,
        tag,
        logType,
        createdAt,
        stackTrace,
      );
}
