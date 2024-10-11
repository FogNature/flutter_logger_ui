import 'package:flutter/material.dart';
import 'package:flutter_awesome_logger/flutter_awesome_logger.dart';
import 'package:flutter_awesome_logger/src/logic/log_page_change_notifier.dart';
import 'package:flutter_awesome_logger/src/models/log.dart';
import 'package:flutter_awesome_logger/src/widgets/log_page/widgets/log_tile.dart';
import 'package:flutter_awesome_logger/src/widgets/logger_localizations_widget.dart';

class LogPage extends StatefulWidget {
  const LogPage({super.key});

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  late TextEditingController _controller;
  late LogPageChangeNotifier changeNotifier;

  @override
  void initState() {
    _controller = TextEditingController();
    changeNotifier = LogPageChangeNotifier(
      FlutterLogSingleton.instance,
    )..logInitialized();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: changeNotifier,
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
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
                  LoggerLocalizations.logsPage,
                ),
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            body: Column(
              children: [
                const SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                  ),
                  child: TextField(
                    onChanged: (value) {
                      changeNotifier.searchStringChanged(value);
                    },
                    controller: _controller,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      label: Text(
                        LoggerLocalizationsWidget.localize(
                          context,
                          LoggerLocalizations.logsSearch,
                        ),
                      ),
                      suffixIcon: changeNotifier.searchString.isEmpty
                          ? null
                          : GestureDetector(
                              onTap: () {
                                changeNotifier.searchStringChanged('');
                              },
                              child: const Icon(
                                Icons.cancel_outlined,
                                color: Color(
                                  0xFF49454F,
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      LoggerLocalizationsWidget.localize(
                        context,
                        LoggerLocalizations.logScreenSubtitle,
                      ),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF49454F),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border.fromBorderSide(BorderSide()),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            12,
                          ),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<LogType>(
                          value: changeNotifier.logType,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          items: List.generate(
                            LogType.values.length,
                            (index) => DropdownMenuItem(
                              value: LogType.values[index],
                              child: Text(
                                _typeForString(
                                  context,
                                  LogType.values[index],
                                ),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          onChanged: (value) {
                            if (value != null) {
                              changeNotifier.logFilterChanged(value);
                            }
                          },
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
                if (changeNotifier.filteredLogs.isEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          LoggerLocalizationsWidget.localize(
                            context,
                            LoggerLocalizations.logScreenLogsEmpty,
                          ),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ],
                  )
                else ...[
                  Divider(
                    color: Colors.black.withOpacity(0.2),
                    height: 1,
                    thickness: 1,
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: changeNotifier.filteredLogs.length,
                      itemBuilder: (context, index) => LogTile(
                        log: changeNotifier.filteredLogs[index],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        });
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
