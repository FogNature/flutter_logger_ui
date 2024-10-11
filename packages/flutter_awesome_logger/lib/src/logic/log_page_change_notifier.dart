import 'package:flutter/widgets.dart';
import 'package:flutter_awesome_logger/src/models/log.dart';
import 'package:flutter_awesome_logger/src/singletones/flutter_log_singleton.dart';

class LogPageChangeNotifier with ChangeNotifier {
  final FlutterLogSingleton logSingleton;
  List<LogEntry> logs = [];
  List<LogEntry> filteredLogs = [];
  LogType logType = LogType.none;
  String searchString = '';

  LogPageChangeNotifier(
    this.logSingleton,
  );

  void logInitialized() {
    logs = logSingleton.logs;
    filteredLogs = logSingleton.logs;
    notifyListeners();

    logSingleton.updateStream.stream.listen((event) {
      logsChanged();
    });
  }

  void logFilterChanged(LogType newLogType) {
    filteredLogs = _applyFilters(
      logSingleton.logs,
      searchString,
      newLogType,
    );
    logType = newLogType;
    notifyListeners();
  }

  void searchStringChanged(String newSearchString) {
    filteredLogs = _applyFilters(
      logSingleton.logs,
      newSearchString,
      logType,
    );
    searchString = newSearchString;
    notifyListeners();
  }

  void logsChanged() {
    logs = logSingleton.logs;
    filteredLogs = _applyFilters(
      logSingleton.logs,
      searchString,
      logType,
    );
    notifyListeners();
  }

  List<LogEntry> _applyFilters(
    List<LogEntry> logs,
    String searchString,
    LogType filter,
  ) {
    List<LogEntry> newLogs = logs;
    if (filter != LogType.none) {
      newLogs = newLogs.where((element) => element.logType == filter).toList();
    }
    if (searchString.length >= 3) {
      newLogs = newLogs
          .where(
            (element) => element.info.toLowerCase().contains(
                  searchString.toLowerCase(),
                ),
          )
          .toList();
    }

    return newLogs;
  }
}
