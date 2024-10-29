import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_logger/flutter_awesome_logger.dart';
import 'package:flutter_awesome_logger/src/singletones/global_dependencies.dart';
import 'package:flutter_awesome_logger/src/widgets/logger_localizations_widget.dart';
import 'package:flutter_awesome_logger/src/widgets/qa_bottom_sheet.dart';
import 'package:flutter_awesome_logger/src/widgets/qa_screen_shake_detector.dart';

class QaScreenWidget extends StatefulWidget {
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
  State<QaScreenWidget> createState() => _QaScreenWidgetState();
}

class _QaScreenWidgetState extends State<QaScreenWidget> {
  bool initialized = false;

  @override
  void initState() {
    super.initState();

    GlobalDependencies()
        .init(
          settings: LoggerSettings(
            enabled: widget.enabled,
            onLog: widget.onLog,
            onHttpLog: widget.onHttpLog,
            onHttpResponse: widget.onHttpResponse,
          ),
        )
        .then(
          (_) => setState(() {
            initialized = true;
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    if ((kDebugMode || widget.enabled) && initialized) {
      return Localizations(
        locale: const Locale('en'),
        delegates: const [
          DefaultMaterialLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        child: LoggerLocalizationsWidget(
          loggerLocalizations: widget.loggerLocalizations,
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
                        child: widget.child,
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

    return widget.child;
  }
}
