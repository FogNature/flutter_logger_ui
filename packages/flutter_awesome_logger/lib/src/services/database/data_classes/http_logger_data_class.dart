import 'package:drift/drift.dart';

@DataClassName('HttpLogData')
class HttpLoggerDataClass extends Table {
  @override
  String get tableName => 'httpLogs';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get method => text()();
  TextColumn get path => text()();
  IntColumn get status => integer().nullable()();
  TextColumn get body => text().nullable()();
  TextColumn get headers => text()();
  TextColumn get query => text()();
  TextColumn get response => text().nullable()();
  TextColumn get error => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}
