import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_awesome_logger/flutter_awesome_logger.dart';
import 'package:flutter_awesome_logger/src/singletones/global_dependencies.dart';
import 'package:flutter_awesome_logger/src/widgets/logger_localizations_widget.dart';
import 'package:flutter_awesome_logger/src/logic/proxy_page_change_notifier.dart';

class ProxyPage extends StatefulWidget {
  const ProxyPage({
    super.key,
  });

  @override
  State<ProxyPage> createState() => _ProxyPageState();
}

class _ProxyPageState extends State<ProxyPage> {
  late TextEditingController _ipController;
  late TextEditingController _portController;
  late FocusNode _ipFocusNode;
  late FocusNode _portFocusNode;
  bool showIpValidationError = false;
  bool showPortValidationError = false;
  late ProxyPageChangeNotifier changeNotifier;

  @override
  void initState() {
    _ipController = TextEditingController();
    _portController = TextEditingController();
    _ipFocusNode = FocusNode();
    _portFocusNode = FocusNode();
    changeNotifier = ProxyPageChangeNotifier(
      GlobalDependencies().proxyChangedStream,
      GlobalDependencies().preferencesService,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: changeNotifier,
      builder: (context, child) => Scaffold(
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
              LoggerLocalizations.proxyPage,
            ),
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
          ),
          child: Column(
            children: [
              Text(
                LoggerLocalizationsWidget.localize(
                  context,
                  LoggerLocalizations.proxyDescription,
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    showIpValidationError = false;
                  });
                  changeNotifier.ipChanged(value);
                },
                focusNode: _ipFocusNode,
                controller: _ipController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(15),
                ],
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  label: Text(
                    LoggerLocalizationsWidget.localize(
                      context,
                      LoggerLocalizations.proxyIpLabel,
                    ),
                  ),
                  error: showIpValidationError
                      ? Text(
                          LoggerLocalizationsWidget.localize(
                            context,
                            LoggerLocalizations.proxyIpError,
                          ),
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        )
                      : null,
                  enabled: changeNotifier.state == ProxyState.disabled,
                  suffixIcon: changeNotifier.state == ProxyState.enabled ||
                          changeNotifier.ip.isEmpty
                      ? null
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              showIpValidationError = false;
                            });
                            changeNotifier.ipChanged('');
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
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    LoggerLocalizationsWidget.localize(
                      context,
                      LoggerLocalizations.proxyIpHint,
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
                height: 16,
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    showPortValidationError = false;
                  });
                  changeNotifier.portChanged(value);
                },
                controller: _portController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(4),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                focusNode: _portFocusNode,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  label: Text(
                    LoggerLocalizationsWidget.localize(
                      context,
                      LoggerLocalizations.proxyPortLabel,
                    ),
                  ),
                  error: showPortValidationError
                      ? Text(
                          LoggerLocalizationsWidget.localize(
                            context,
                            LoggerLocalizations.proxyPortError,
                          ),
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        )
                      : null,
                  enabled: changeNotifier.state == ProxyState.disabled,
                  suffixIcon: changeNotifier.state == ProxyState.enabled ||
                          changeNotifier.port.isEmpty
                      ? null
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              showPortValidationError = false;
                            });
                            changeNotifier.portChanged('');
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
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    LoggerLocalizationsWidget.localize(
                      context,
                      LoggerLocalizations.proxyPortHint,
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
                height: 32,
              ),
              Row(
                children: [
                  Text(
                    LoggerLocalizationsWidget.localize(
                      context,
                      LoggerLocalizations.proxyEnable,
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                  Switch.adaptive(
                    value: changeNotifier.state == ProxyState.enabled,
                    onChanged: (_) {
                      if (changeNotifier.ip.isNotEmpty &&
                              changeNotifier.port.length > 1 ||
                          changeNotifier.state == ProxyState.enabled) {
                        changeNotifier.toggleProxy();
                      } else {
                        if (changeNotifier.ip.isEmpty) {
                          setState(() {
                            showIpValidationError = true;
                          });
                        }

                        if (changeNotifier.port.length <= 1) {
                          setState(() {
                            showPortValidationError = true;
                          });
                        }
                      }
                    },
                  ),
                ],
              ),
              if (changeNotifier.appliedProxy.isNotEmpty &&
                  changeNotifier.state == ProxyState.enabled) ...[
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LoggerLocalizationsWidget.localize(
                        context,
                        LoggerLocalizations.proxyRunning,
                      ),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      changeNotifier.appliedProxy,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
