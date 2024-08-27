import 'package:flutter_awesome_logger/src/services/database/database.dart';

abstract class IPackageDatabase {
  Future<List<HttpLogData>> getHttpLogs({
    required String? path,
    required int? status,
    required String? method,
    int pageSize,
    required int page,
  });

  Future<void> addHttpLog(HttpLoggerDataClassCompanion log);

  Future<List<LogData>> getLogs({
    required int? logLevel,
    required String? tag,
    required String? search,
    int pageSize,
    required int page,
  });

  Future<void> addLog(LoggerDataClassCompanion log);

  Future<void> clearDatabase();
}
