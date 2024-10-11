import 'package:flutter/cupertino.dart';
import 'package:flutter_awesome_logger/src/utils/logger_localizations.dart';

class LoggerLocalizationsWidget extends InheritedWidget {
  final Map<LoggerLocalizations, String>? loggerLocalizations;

  const LoggerLocalizationsWidget({
    super.key,
    required super.child,
    this.loggerLocalizations,
  });

  static String localize(BuildContext context, LoggerLocalizations key) {
    final result = context
        .dependOnInheritedWidgetOfExactType<LoggerLocalizationsWidget>()!;

    return result.loggerLocalizations?[key] ?? _defaultLocalizations[key] ?? '';
  }

  @override
  bool updateShouldNotify(covariant LoggerLocalizationsWidget oldWidget) {
    return child != oldWidget.child ||
        loggerLocalizations != oldWidget.loggerLocalizations;
  }
}

const _defaultLocalizations = <LoggerLocalizations, String>{
  LoggerLocalizations.appName: 'Application name',
  LoggerLocalizations.buildNumber: "Build number",
  LoggerLocalizations.qaScreenName: "Application name",
  LoggerLocalizations.proxyPage: "Proxy",
  LoggerLocalizations.proxyDescription:
      "Proxy can be used to intercept and analyze requests",
  LoggerLocalizations.proxyPageDescription:
      "Proxy can be used to intercept requests in Flutter applications",
  LoggerLocalizations.proxyIpLabel: "IP address",
  LoggerLocalizations.proxyIpHint: "Proxy IP address",
  LoggerLocalizations.proxyIpError: "IP address cannot be empty",
  LoggerLocalizations.proxyPortLabel: "Port",
  LoggerLocalizations.proxyPortHint: "Proxy port",
  LoggerLocalizations.proxyPortError: "Incorrect port",
  LoggerLocalizations.proxyEnable: "Enable",
  LoggerLocalizations.proxyRunning: "Proxy is running on",
  LoggerLocalizations.logsPage: "Logs",
  LoggerLocalizations.logsDescription: "List of Flutter logs",
  LoggerLocalizations.logsSearch: "Search",
  LoggerLocalizations.logScreenSubtitle: "Start entering text for filtering",
  LoggerLocalizations.logScreenErrorType: "Errors",
  LoggerLocalizations.logScreenFlutterType: "Flutter",
  LoggerLocalizations.logScreenCustomType: "Custom",
  LoggerLocalizations.logScreenAnyType: "Any",
  LoggerLocalizations.logScreenLogStacktrace: "Stack trace",
  LoggerLocalizations.logScreenCopyStacktrace: "Copy Stack trace",
  LoggerLocalizations.logScreenLogsEmpty: 'No logs found',
  LoggerLocalizations.httpLogsPage: "HTTP Logs",
  LoggerLocalizations.httpLogsDescription: "All HTTP Logs of application",
  LoggerLocalizations.httpLogsSearch: "Start entering path",
  LoggerLocalizations.httpLogsEmptyStatus: "Any status",
  LoggerLocalizations.httpLogsPendingStatus: "Pending",
  LoggerLocalizations.httpLogsOtherStatus: "Other",
  LoggerLocalizations.httpLogsNoInternetStatus: "No internet",
  LoggerLocalizations.httpLogsEmptyMethod: "Any Method",
  LoggerLocalizations.httpLogsStatusDescription: "Status: ",
  LoggerLocalizations.httpLogsHeaders: "Headers",
  LoggerLocalizations.httpLogsQuery: "Query",
  LoggerLocalizations.httpLogsBody: "Body",
  LoggerLocalizations.httpLogsSendAt: "Send at:",
  LoggerLocalizations.httpLogsReceivedAt: "Received at: ",
  LoggerLocalizations.httpLogsRequest: "Request",
  LoggerLocalizations.httpLogsResponse: "Response",
  LoggerLocalizations.httpLogsBaseUrl: "Base url: ",
  LoggerLocalizations.httpLogsMethod: "HTTP Method: ",
  LoggerLocalizations.httpLogsScreenLogsEmpty: "Empty screen",
};
