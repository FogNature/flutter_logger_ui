import 'package:flutter_awesome_logger/src/services/shared_preferences_service/shared_preferences_service.dart';

class ProxySingleton {
  late SharedPreferencesService _preferencesService;
  String? proxy;

  factory ProxySingleton() {
    return _instance;
  }

  static final ProxySingleton _instance = ProxySingleton._internal();

  ProxySingleton._internal();

  Future<void> init({
    required SharedPreferencesService preferencesService,
  }) async {
    _preferencesService = preferencesService;

    proxy = preferencesService.getString(proxyName);
  }

  Future<void> setProxy(String ip, String port) async {
    proxy = 'PROXY $ip:$port;';

    _preferencesService.setString(
      proxyName,
      'PROXY $ip:$port;',
    );
  }

  Future<void> removeProxy() async {
    proxy = null;
    await _preferencesService.clearValue(proxyName);
  }
}
