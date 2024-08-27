import 'package:flutter/cupertino.dart';
import 'package:flutter_awesome_logger/src/models/http_log.dart';
import 'package:flutter_awesome_logger/src/models/log.dart';

class LoggerChangeNotifier extends ChangeNotifier {
  List<LogEntry> logs = [];
  List<HttpLogEntry> httpLogs = [];
  String? proxy;
}
