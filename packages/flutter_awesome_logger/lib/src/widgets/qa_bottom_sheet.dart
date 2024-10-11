import 'package:flutter/material.dart';
import 'package:flutter_awesome_logger/flutter_awesome_logger.dart';
import 'package:flutter_awesome_logger/src/logic/qa_screen_change_notifier.dart';
import 'package:flutter_awesome_logger/src/singletones/global_dependencies.dart';
import 'package:flutter_awesome_logger/src/singletones/proxy_stream_singleton.dart';
import 'package:flutter_awesome_logger/src/widgets/feature_tile.dart';
import 'package:flutter_awesome_logger/src/widgets/http_log_page/http_log_page.dart';
import 'package:flutter_awesome_logger/src/widgets/log_page/log_page.dart';
import 'package:flutter_awesome_logger/src/widgets/logger_localizations_widget.dart';
import 'package:flutter_awesome_logger/src/widgets/proxy_page/proxy_page.dart';

class QaBottomSheet extends StatefulWidget {
  const QaBottomSheet({
    super.key,
  });

  @override
  State<QaBottomSheet> createState() => _QaBottomSheetState();
}

class _QaBottomSheetState extends State<QaBottomSheet> {
  late QaScreenChangeNotifier changeNotifier;

  @override
  void initState() {
    changeNotifier = QaScreenChangeNotifier(
      GlobalDependencies().deviceInfoSingleton,
      ProxyStreamSingleton().proxyStream.stream,
      GlobalDependencies().preferencesService,
    )..initialized();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: changeNotifier,
      builder: (context, _) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              child: Text(
                LoggerLocalizationsWidget.localize(
                  context,
                  LoggerLocalizations.qaScreenName,
                ),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              child: Text(
                changeNotifier.appName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              child: Text(
                LoggerLocalizationsWidget.localize(
                  context,
                  LoggerLocalizations.buildNumber,
                ),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              child: Text(
                changeNotifier.version,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Divider(
              color: Colors.black.withOpacity(0.2),
              height: 1,
              thickness: 1,
            ),
            FeatureTile(
              title: Row(
                children: [
                  Text(
                    LoggerLocalizationsWidget.localize(
                      context,
                      LoggerLocalizations.proxyPage,
                    ),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Icon(
                    changeNotifier.proxyEnabled
                        ? Icons.check_circle
                        : Icons.check_circle_outline,
                    color: changeNotifier.proxyEnabled
                        ? Colors.green
                        : Colors.black,
                  ),
                ],
              ),
              description: LoggerLocalizationsWidget.localize(
                context,
                LoggerLocalizations.proxyDescription,
              ),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProxyPage(),
                ),
              ),
            ),
            Divider(
              color: Colors.black.withOpacity(0.2),
              height: 1,
              thickness: 1,
            ),
            FeatureTile(
              name: LoggerLocalizationsWidget.localize(
                  context, LoggerLocalizations.logsPage),
              description: LoggerLocalizationsWidget.localize(
                  context, LoggerLocalizations.logsDescription),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LogPage(),
                ),
              ),
            ),
            Divider(
              color: Colors.black.withOpacity(0.2),
              height: 1,
              thickness: 1,
            ),
            FeatureTile(
              name: LoggerLocalizationsWidget.localize(
                context,
                LoggerLocalizations.httpLogsPage,
              ),
              description: LoggerLocalizationsWidget.localize(
                context,
                LoggerLocalizations.httpLogsDescription,
              ),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HttpLogPage(),
                ),
              ),
            ),
            Divider(
              color: Colors.black.withOpacity(0.2),
              height: 1,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
