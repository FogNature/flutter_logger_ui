import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_awesome_logger/flutter_awesome_logger.dart';
import 'package:flutter_awesome_logger/src/models/log.dart';
import 'package:flutter_awesome_logger/src/models/log_type.dart';
import 'package:flutter_awesome_logger/src/utils/format_log_time.dart';
import 'package:flutter_awesome_logger/src/widgets/logger_localizations_widget.dart';

class LogTile extends StatefulWidget {
  const LogTile({
    super.key,
    required this.log,
  });

  final LogEntry log;

  @override
  State<LogTile> createState() => _LogTileState();
}

class _LogTileState extends State<LogTile> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 7,
        ),
        Row(
          children: [
            const SizedBox(
              width: 14,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _typeForString(context, widget.log.logType),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: widget.log.logType == LogType.error
                          ? Colors.red
                          : Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    widget.log.info,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    formatLogTime(widget.log.createdAt),
                  ),
                ],
              ),
            ),
            if (widget.log.stackTrace != null)
              GestureDetector(
                onTap: () => setState(() {
                  expanded = !expanded;
                }),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 14,
                  ),
                  color: Colors.transparent,
                  child: Icon(
                    expanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  ),
                ),
              )
            else
              const SizedBox(width: 14)
          ],
        ),
        if (expanded) ...[
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: Text(
              LoggerLocalizationsWidget.localize(
                context,
                LoggerLocalizations.logScreenLogStacktrace,
              ),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: OutlinedButton(
                  onPressed: () async {
                    await Clipboard.setData(
                      ClipboardData(
                        text: widget.log.stackTrace ?? '',
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LoggerLocalizationsWidget.localize(
                          context,
                          LoggerLocalizations.logScreenCopyStacktrace,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Icon(
                        Icons.copy,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Text(
              widget.log.stackTrace ?? '',
            ),
          ),
        ],
        const SizedBox(
          height: 7,
        ),
        Divider(
          color: Colors.black.withOpacity(0.2),
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }

  String _typeForString(BuildContext context, LogType type) {
    switch (type) {
      case LogType.flutter:
        return LoggerLocalizationsWidget.localize(
          context,
          LoggerLocalizations.logScreenFlutterType,
        );
      case LogType.custom:
        return LoggerLocalizationsWidget.localize(
          context,
          LoggerLocalizations.logScreenCustomType,
        );
      case LogType.error:
        return LoggerLocalizationsWidget.localize(
          context,
          LoggerLocalizations.logScreenErrorType,
        );
      case LogType.none:
        return LoggerLocalizationsWidget.localize(
          context,
          LoggerLocalizations.logScreenAnyType,
        );
    }
  }
}
