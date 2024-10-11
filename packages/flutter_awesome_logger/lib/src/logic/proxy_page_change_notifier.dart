import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_awesome_logger/src/services/shared_preferences_service.dart';

enum ProxyState { enabled, disabled }

class ProxyPageChangeNotifier with ChangeNotifier {
  final StreamController<String?> proxyChangeStream;
  final SharedPreferencesService sharedPreferencesService;
  String ip = '';
  String port = '';
  String appliedProxy = '';
  ProxyState state = ProxyState.disabled;

  ProxyPageChangeNotifier(
    this.proxyChangeStream,
    this.sharedPreferencesService,
  );

  void proxyInitialized() async {
    final proxy = sharedPreferencesService.getString(proxyName) ?? '';
    if (proxy.split(':').length == 2) {
      ip = proxy.split(':').first;
      port = proxy.split(':').last;
      appliedProxy = proxy;
      state = ProxyState.enabled;
    } else {
      ip = '';
      port = '';
      appliedProxy = '';
      state = ProxyState.disabled;
    }
    notifyListeners();
  }

  void ipChanged(String newIp) {
    ip = newIp;
    state = ProxyState.disabled;
    notifyListeners();
  }

  void portChanged(String newPort) {
    port = newPort;
    state = ProxyState.disabled;
    notifyListeners();
  }

  void toggleProxy() async {
    if (state == ProxyState.disabled) {
      state = ProxyState.enabled;
      appliedProxy = '$ip:$port';
      await sharedPreferencesService.setString(
        proxyName,
        '$ip:$port',
      );

      proxyChangeStream.add('$ip:$port');
    } else {
      state = ProxyState.disabled;

      await sharedPreferencesService.clearValue(proxyName);
      proxyChangeStream.add(null);
    }
    notifyListeners();
  }
}
