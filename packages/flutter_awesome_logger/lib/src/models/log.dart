import 'package:flutter_awesome_logger/src/services/database/database.dart';

enum LogLever {
  trace,
  debug,
  info,
  warning,
  error,
}

class LogEntry {
  final int id;
  final String info;
  final String tag;
  final LogLever logLever;
  final DateTime createdAt;

  LogEntry({
    required this.id,
    required this.info,
    required this.logLever,
    required this.createdAt,
    required this.tag,
  });

  factory LogEntry.fromTableData(LogData data) => LogEntry(
        id: data.id,
        info: data.info,
        logLever: LogLever.values[data.logLever],
        createdAt: data.createdAt,
        tag: data.tag,
      );

  @override
  String toString() {
    return 'LogEntry(id: $id, logLever: $logLever, createdAt: $createdAt, tag: $tag, info: $info,)';
  }

  @override
  bool operator ==(Object other) =>
      other is LogEntry &&
      id == other.id &&
      logLever == other.logLever &&
      createdAt == other.createdAt &&
      tag == other.tag &&
      info == other.info;

  LogEntry copyWith({
    int? id,
    String? info,
    LogLever? logLever,
    DateTime? createdAt,
    String? tag,
  }) =>
      LogEntry(
        id: id ?? this.id,
        info: info ?? this.info,
        logLever: logLever ?? this.logLever,
        createdAt: createdAt ?? this.createdAt,
        tag: tag ?? this.tag,
      );

  @override
  int get hashCode => Object.hash(
        id,
        logLever,
        createdAt,
        tag,
        info,
      );
}
