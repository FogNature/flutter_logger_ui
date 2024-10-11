import 'package:flutter/material.dart';
import 'package:flutter_awesome_logger/flutter_awesome_logger.dart';
import 'package:flutter_awesome_logger/src/models/http_log.dart';
import 'package:flutter_awesome_logger/src/utils/format_log_time.dart';
import 'package:flutter_awesome_logger/src/widgets/http_log_page/widgets/json_viewer.dart';
import 'package:flutter_awesome_logger/src/widgets/logger_localizations_widget.dart';

class ResponseInfo extends StatelessWidget {
  const ResponseInfo({
    super.key,
    required this.log,
  });

  final HttpLogEntry log;

  @override
  Widget build(BuildContext context) {
    if (log.status == -3) {
      return const SizedBox();
    }
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
              LoggerLocalizations.httpLogsResponse,
            ),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (log.responseTime != null)
            Text(
              '${LoggerLocalizationsWidget.localize(
                context,
                LoggerLocalizations.httpLogsReceivedAt,
              )}${formatLogTime(
                log.responseTime!,
              )}',
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          JsonViewer(
            title: LoggerLocalizationsWidget.localize(
              context,
              LoggerLocalizations.httpLogsBody,
            ),
            json: log.response,
          ),
        ],
      ),
    );
  }
}
