import 'package:flutter/cupertino.dart';
import 'package:flutter_awesome_logger/src/models/http_log.dart';
import 'package:flutter_awesome_logger/src/singletones/flutter_log_singleton.dart';
import 'package:flutter_awesome_logger/src/utils/http_status_code_constants.dart';

class HttpLogPageChangeNotifier with ChangeNotifier {
  List<HttpLogEntry> httpLogs = [];
  List<HttpLogEntry> filteredHttpLogs = [];
  String method = '';
  int status = HttpStatusCodeConstants.noFilter;
  String searchString = '';
  String selectedBaseUrl = '';
  List<String> baseUrls = [];

  final FlutterLogSingleton loggerSingleton;

  HttpLogPageChangeNotifier(this.loggerSingleton);

  void initialized() {
    httpLogs = loggerSingleton.httpLogs;
    filteredHttpLogs = loggerSingleton.httpLogs;
    baseUrls = loggerSingleton.httpLogs.map((e) => e.baseUrl).toSet().toList();

    notifyListeners();
    loggerSingleton.updateStream.stream.listen((event) {
      httpLogsChanged();
    });
  }

  void methodChanged(String newMethod) {
    filteredHttpLogs = _filterLogs(
      logs: loggerSingleton.httpLogs,
      searchString: method,
      method: newMethod,
      status: status,
      selectedBaseUrl: selectedBaseUrl,
    );
    method = newMethod;
    notifyListeners();
  }

  void searchStringChanged(String newSearchString) {
    filteredHttpLogs = _filterLogs(
      logs: loggerSingleton.httpLogs,
      searchString: newSearchString,
      method: method,
      status: status,
      selectedBaseUrl: selectedBaseUrl,
    );
    searchString = newSearchString;
    notifyListeners();
  }

  void statusChanged(int newStatus) {
    filteredHttpLogs = _filterLogs(
      logs: loggerSingleton.httpLogs,
      searchString: searchString,
      method: method,
      status: newStatus,
      selectedBaseUrl: selectedBaseUrl,
    );
    status = newStatus;
    notifyListeners();
  }

  void baseUrlChanged(String newBaseUrl) {
    filteredHttpLogs = _filterLogs(
      logs: loggerSingleton.httpLogs,
      searchString: searchString,
      method: method,
      status: status,
      selectedBaseUrl: newBaseUrl,
    );
    selectedBaseUrl = newBaseUrl;
    notifyListeners();
  }

  void httpLogsChanged() {
    httpLogs = loggerSingleton.httpLogs;
    filteredHttpLogs = _filterLogs(
      logs: loggerSingleton.httpLogs,
      searchString: searchString,
      method: method,
      status: status,
      selectedBaseUrl: selectedBaseUrl,
    );
    notifyListeners();
  }

  List<HttpLogEntry> _filterLogs({
    required List<HttpLogEntry> logs,
    required String searchString,
    required String method,
    required int status,
    required String selectedBaseUrl,
  }) {
    Iterable<HttpLogEntry> filteredLogs = logs;

    if (method.isNotEmpty) {
      filteredLogs = filteredLogs.where(
        (element) => element.method.toLowerCase() == method.toLowerCase(),
      );
    }

    if (selectedBaseUrl.isNotEmpty) {
      filteredLogs =
          filteredLogs.where((element) => element.baseUrl == selectedBaseUrl);
    }
    if (searchString.length >= 3) {
      filteredLogs = filteredLogs.where(
        (element) => element.path.toLowerCase().contains(
              searchString.toLowerCase(),
            ),
      );
    }
    const allStatuses = [
      HttpStatusCodeConstants.noInternet,
      HttpStatusCodeConstants.pending,
      200,
      400,
      401,
      404,
      500,
    ];
    if (allStatuses.contains(status)) {
      filteredLogs = filteredLogs.where((element) => element.status == status);
    }
    if (status == HttpStatusCodeConstants.other) {
      const statuses = [200, 400, 401, 404, 500];

      filteredLogs = filteredLogs
          .where((element) => element.status > 0 && !statuses.contains(status));
    }
    return filteredLogs.toList();
  }
}
