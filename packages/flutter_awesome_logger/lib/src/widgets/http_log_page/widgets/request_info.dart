import 'package:flutter/material.dart';
import 'package:flutter_awesome_logger/flutter_awesome_logger.dart';
import 'package:flutter_awesome_logger/src/models/http_log.dart';
import 'package:flutter_awesome_logger/src/utils/format_log_time.dart';
import 'package:flutter_awesome_logger/src/widgets/http_log_page/widgets/json_viewer.dart';
import 'package:flutter_awesome_logger/src/widgets/logger_localizations_widget.dart';

class RequestInfo extends StatelessWidget {
  const RequestInfo({
    super.key,
    required this.log,
  });

  final HttpLogEntry log;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
        right: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LoggerLocalizationsWidget.localize(
              context,
              LoggerLocalizations.httpLogsRequest,
            ),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            '${LoggerLocalizationsWidget.localize(
              context,
              LoggerLocalizations.httpLogsSendAt,
            )}${formatLogTime(log.createdAt)}',
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          JsonViewer(
            title: LoggerLocalizationsWidget.localize(
              context,
              LoggerLocalizations.httpLogsHeaders,
            ),
            json: log.headers,
          ),
          JsonViewer(
            title: LoggerLocalizationsWidget.localize(
              context,
              LoggerLocalizations.httpLogsQuery,
            ),
            json: log.query,
          ),
          JsonViewer(
            title: LoggerLocalizationsWidget.localize(
              context,
              LoggerLocalizations.httpLogsBody,
            ),
            json: log.body,
          ),
        ],
      ),
    );
  }
}
