import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_awesome_logger/src/services/database/data_classes/http_logger_data_class.dart';
import 'package:flutter_awesome_logger/src/services/database/data_classes/logger_data_class.dart';
import 'package:flutter_awesome_logger/src/services/database/database_interface.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    LoggerDataClass,
    HttpLoggerDataClass,
  ],
)
class PackageDatabase extends _$PackageDatabase implements IPackageDatabase {
  PackageDatabase(super.e);

  @override
  int get schemaVersion => 1;

  @override
  Future<void> addHttpLog(HttpLoggerDataClassCompanion log) =>
      into(httpLoggerDataClass).insert(log);

  @override
  Future<void> addLog(LoggerDataClassCompanion log) =>
      into(loggerDataClass).insert(log);

  @override
  Future<void> clearDatabase() => clearDatabase();

  @override
  Future<List<HttpLogData>> getHttpLogs({
    required String? path,
    required int? status,
    required String? method,
    int pageSize = 50,
    required int page,
  }) =>
      (select(httpLoggerDataClass)
            ..where(
              (tbl) {
                final trueExpr = tbl.id.isNotNull();
                final pathExpression =
                    path != null ? tbl.path.contains(path) : trueExpr;
                final statusExpression =
                    status != null ? tbl.status.equals(status) : trueExpr;
                final methodExpression =
                    method != null ? tbl.method.equals(method) : trueExpr;

                return pathExpression & statusExpression & methodExpression;
              },
            )
            ..limit(pageSize, offset: pageSize * page))
          .get();

  @override
  Future<List<LogData>> getLogs({
    required int? logLevel,
    required String? tag,
    required String? search,
    int pageSize = 50,
    required int page,
  }) =>
      (select(loggerDataClass)
            ..where(
              (tbl) {
                final trueExpr = tbl.id.isNotNull();
                final logExpression =
                    logLevel != null ? tbl.logLever.equals(logLevel) : trueExpr;
                final tagExpression =
                    tag != null ? tbl.tag.equals(tag) : trueExpr;
                final searchExpression =
                    search != null ? tbl.info.contains(search) : trueExpr;

                return logExpression & tagExpression & searchExpression;
              },
            )
            ..limit(pageSize, offset: pageSize * page))
          .get();
}

LazyDatabase openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();

    final file = File(
      join('${dbFolder.path}/flutter_awesome_logger', 'packageDb.sqlite'),
    );

    return NativeDatabase(file);
  });
}
