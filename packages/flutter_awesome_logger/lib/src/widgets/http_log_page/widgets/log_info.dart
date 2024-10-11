import 'package:flutter/material.dart';
import 'package:flutter_awesome_logger/flutter_awesome_logger.dart';
import 'package:flutter_awesome_logger/src/models/http_log.dart';
import 'package:flutter_awesome_logger/src/utils/format_log_time.dart';
import 'package:flutter_awesome_logger/src/widgets/logger_localizations_widget.dart';

class LogInfo extends StatelessWidget {
  const LogInfo({
    super.key,
    required this.log,
  });

  final HttpLogEntry log;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          log.path,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          '${LoggerLocalizationsWidget.localize(
            context,
            LoggerLocalizations.httpLogsBaseUrl,
          )}${log.baseUrl}',
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          '${LoggerLocalizationsWidget.localize(
            context,
            LoggerLocalizations.httpLogsMethod,
          )}${log.method}',
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
            Text(
              LoggerLocalizationsWidget.localize(
                context,
                LoggerLocalizations.httpLogsStatusDescription,
              ),
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            Text(
              _getLogStatus(
                context,
                log.status,
              ),
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: _getLogStatusColor(log.status),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          formatLogTime(log.createdAt),
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  String _getLogStatus(BuildContext context, int status) {
    switch (status) {
      case 0:
        return LoggerLocalizationsWidget.localize(
          context,
          LoggerLocalizations.httpLogsPendingStatus,
        );
      case -1:
        return LoggerLocalizationsWidget.localize(
          context,
          LoggerLocalizations.httpLogsNoInternetStatus,
        );
      case -3:
        return LoggerLocalizationsWidget.localize(
          context,
          LoggerLocalizations.httpLogsEmptyStatus,
        );
      default:
        return status.toString();
    }
  }

  Color _getLogStatusColor(int status) {
    if (status == 0) {
      return const Color(0xFF49454F);
    }
    if (status == -1) {
      return const Color(0xFFC73B34);
    }

    if (status >= 400) {
      return const Color(0xFFC73B34);
    }
    return const Color(0xFF34C759);
  }
}
