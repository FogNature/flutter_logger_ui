import 'package:flutter/material.dart';
import 'package:flutter_awesome_logger/flutter_awesome_logger.dart';
import 'package:flutter_awesome_logger/src/models/http_log.dart';
import 'package:flutter_awesome_logger/src/widgets/http_log_page/widgets/log_info.dart';
import 'package:flutter_awesome_logger/src/widgets/http_log_page/widgets/request_info.dart';
import 'package:flutter_awesome_logger/src/widgets/http_log_page/widgets/response_info.dart';
import 'package:flutter_awesome_logger/src/widgets/logger_localizations_widget.dart';

class DetailHttpLogPage extends StatelessWidget {
  const DetailHttpLogPage({
    super.key,
    required this.log,
  });

  final HttpLogEntry log;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 0,
        title: Text(
          LoggerLocalizationsWidget.localize(
            context,
            LoggerLocalizations.httpLogsPage,
          ),
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: LogInfo(log: log),
            ),
            const SizedBox(
              height: 24,
            ),
            Divider(
              color: Colors.black.withOpacity(0.2),
              height: 1,
              thickness: 1,
            ),
            const SizedBox(
              height: 16,
            ),
            RequestInfo(log: log),
            const SizedBox(
              height: 16,
            ),
            Divider(
              color: Colors.black.withOpacity(0.2),
              height: 1,
              thickness: 1,
            ),
            const SizedBox(
              height: 16,
            ),
            ResponseInfo(log: log),
          ],
        ),
      ),
    );
  }
}
