import 'package:flutter/material.dart';
import 'package:flutter_awesome_logger/src/services/shared_preferences_service.dart';
import 'package:flutter_awesome_logger/src/singletones/device_info_singleton.dart';

class QaScreenChangeNotifier with ChangeNotifier {
  String version = '';
  String appName = '';
  bool proxyEnabled = false;

  final DeviceInfoSingleton deviceInfoSingleton;
  final Stream<String?> proxyChangedStream;
  final SharedPreferencesService sharedPreferencesService;

  QaScreenChangeNotifier(
    this.deviceInfoSingleton,
    this.proxyChangedStream,
    this.sharedPreferencesService,
  ) {
    proxyChangedStream.listen((event) {
      _proxyChanged();
    });
  }

  initialized() async {
    String versionString = '';
    if (deviceInfoSingleton.version.isNotEmpty) {
      versionString = deviceInfoSingleton.version;
      if (deviceInfoSingleton.buildNumber.isNotEmpty) {
        versionString = '$versionString+${deviceInfoSingleton.buildNumber}';
      }
    }
    final proxy = sharedPreferencesService.getString(proxyName);

    version = versionString;
    appName = deviceInfoSingleton.appName;
    proxyEnabled = proxy?.isNotEmpty ?? false;
    notifyListeners();
  }

  _proxyChanged() async {
    final proxy = sharedPreferencesService.getString(proxyName);

    proxyEnabled = proxy?.isNotEmpty ?? false;
    notifyListeners();
  }
}
