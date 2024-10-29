import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_logger/flutter_awesome_logger.dart';
import 'package:flutter_awesome_logger/src/singletones/global_dependencies.dart';
import 'package:flutter_awesome_logger/src/widgets/logger_localizations_widget.dart';
import 'package:flutter_awesome_logger/src/widgets/qa_bottom_sheet.dart';
import 'package:flutter_awesome_logger/src/widgets/qa_screen_shake_detector.dart';

class QaScreenWidget extends StatelessWidget {
  const QaScreenWidget({
    super.key,
    required this.enabled,
    required this.child,
    this.loggerLocalizations,
    this.onLog,
    this.onHttpLog,
    this.onHttpResponse,
  });

  final bool enabled;
  final Widget child;
  final Map<LoggerLocalizations, String>? loggerLocalizations;
  final VoidCallback? onLog;
  final VoidCallback? onHttpLog;
  final VoidCallback? onHttpResponse;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode || enabled) {
      return FutureBuilder(
        future: GlobalDependencies().init(
          settings: LoggerSettings(
            enabled: enabled,
            onLog: onLog,
            onHttpLog: onHttpLog,
            onHttpResponse: onHttpResponse,
          ),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Localizations(
              locale: const Locale('ru'),
              delegates: const [
                DefaultMaterialLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate,
                DefaultWidgetsLocalizations.delegate,
              ],
              child: LoggerLocalizationsWidget(
                loggerLocalizations: loggerLocalizations,
                child: Navigator(
                  onPopPage: (page, _) {
                    return false;
                  },
                  pages: [
                    MaterialPage(
                      child: Builder(
                        builder: (context) {
                          return QaScreenShakeDetector(
                            onShake: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => const QaBottomSheet(),
                              );
                            },
                            child: PopScope(
                              canPop: false,
                              onPopInvokedWithResult: (_, result) => false,
                              child: child,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return child;
        },
      );
    }

    return child;
  }
}
