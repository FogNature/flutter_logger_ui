import 'package:flutter/material.dart';
import 'package:flutter_awesome_logger/flutter_awesome_logger.dart';
import 'package:flutter_awesome_logger/src/logic/http_log_page_change_notifier.dart';
import 'package:flutter_awesome_logger/src/widgets/logger_localizations_widget.dart';
import 'package:flutter_awesome_logger/src/widgets/qa_dropdown.dart';

class DropdownsList extends StatelessWidget {
  const DropdownsList({super.key, required this.changeNotifier});

  final HttpLogPageChangeNotifier changeNotifier;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: changeNotifier,
      builder: (context, child) {
        return SingleChildScrollView(
          child: Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              if (changeNotifier.baseUrls.length > 1) ...[
                QaDropdown(
                  values: changeNotifier.baseUrls,
                  titles: changeNotifier.baseUrls,
                  selectedValue: changeNotifier.selectedBaseUrl,
                  onSelected: (value) {
                    changeNotifier.baseUrlChanged(value);
                  },
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
              QaDropdown<int>(
                values: [
                  HttpStatusCodeConstants.noFilter,
                  HttpStatusCodeConstants.other,
                  HttpStatusCodeConstants.pending,
                  HttpStatusCodeConstants.noInternet,
                  200,
                  400,
                  401,
                  404,
                  500,
                ],
                titles: [
                  LoggerLocalizationsWidget.localize(
                    context,
                    LoggerLocalizations.httpLogsEmptyStatus,
                  ),
                  LoggerLocalizationsWidget.localize(
                    context,
                    LoggerLocalizations.httpLogsOtherStatus,
                  ),
                  LoggerLocalizationsWidget.localize(
                    context,
                    LoggerLocalizations.httpLogsPendingStatus,
                  ),
                  LoggerLocalizationsWidget.localize(
                    context,
                    LoggerLocalizations.httpLogsNoInternetStatus,
                  ),
                  '200',
                  '400',
                  "401",
                  "404",
                  "500"
                ],
                selectedValue: changeNotifier.status,
                onSelected: (value) {
                  changeNotifier.statusChanged(value);
                },
              ),
              const SizedBox(
                width: 16,
              ),
              QaDropdown<String>(
                values: ['', 'GET', 'POST', 'PATCH', 'PUT', 'DELETE'],
                titles: [
                  LoggerLocalizationsWidget.localize(
                    context,
                    LoggerLocalizations.httpLogsEmptyMethod,
                  ),
                  "GET",
                  "POST",
                  "PATCH",
                  "PUT",
                  "DELETE",
                ],
                selectedValue: changeNotifier.method,
                onSelected: (value) {
                  changeNotifier.methodChanged(value);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
