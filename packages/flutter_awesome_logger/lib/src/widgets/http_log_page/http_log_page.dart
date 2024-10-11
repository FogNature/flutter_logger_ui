import 'package:flutter/material.dart';
import 'package:flutter_awesome_logger/flutter_awesome_logger.dart';
import 'package:flutter_awesome_logger/src/logic/http_log_page_change_notifier.dart';
import 'package:flutter_awesome_logger/src/widgets/http_log_page/widgets/dropdowns_list.dart';
import 'package:flutter_awesome_logger/src/widgets/http_log_page/widgets/http_log_tile.dart';
import 'package:flutter_awesome_logger/src/widgets/logger_localizations_widget.dart';

class HttpLogPage extends StatefulWidget {
  const HttpLogPage({super.key});

  @override
  State<HttpLogPage> createState() => _HttpLogPageState();
}

class _HttpLogPageState extends State<HttpLogPage> {
  late TextEditingController _controller;
  late HttpLogPageChangeNotifier _changeNotifier;

  @override
  void initState() {
    _controller = TextEditingController();
    _changeNotifier = HttpLogPageChangeNotifier(
      FlutterLogSingleton.instance,
    )..initialized();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _changeNotifier,
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
                LoggerLocalizations.httpLogsPage,
              ),
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w700,
              ),
            ),
            surfaceTintColor: Colors.transparent,
          ),
          body: SafeArea(
            child: Column(
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
                      _changeNotifier.searchStringChanged(value);
                    },
                    controller: _controller,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      label: Text(
                        LoggerLocalizationsWidget.localize(
                          context,
                          LoggerLocalizations.httpLogsSearch,
                        ),
                      ),
                      suffixIcon: _changeNotifier.searchString.isEmpty
                          ? null
                          : GestureDetector(
                              onTap: () {
                                _changeNotifier.searchStringChanged('');
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
                        LoggerLocalizations.httpLogsSearchDescription,
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
                DropdownsList(
                  changeNotifier: _changeNotifier,
                ),
                const SizedBox(
                  height: 8,
                ),
                if (_changeNotifier.filteredHttpLogs.isEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          LoggerLocalizationsWidget.localize(
                            context,
                            LoggerLocalizations.httpLogsScreenLogsEmpty,
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
                      itemCount: _changeNotifier.filteredHttpLogs.length,
                      itemBuilder: (context, index) => HttpLogTile(
                        log: _changeNotifier.filteredHttpLogs[index],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
