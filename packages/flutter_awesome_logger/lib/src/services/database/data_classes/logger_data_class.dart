import 'package:drift/drift.dart';

@DataClassName('LogData')
class LoggerDataClass extends Table {
  @override
  String get tableName => 'logs';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get logLever => integer()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get tag => text()();
  TextColumn get info => text()();
}
