import 'dart:async';

import 'package:flutter_awesome_logger/flutter_awesome_logger.dart';
import 'package:flutter_awesome_logger/src/services/shared_preferences_service.dart';
import 'package:flutter_awesome_logger/src/singletones/device_info_singleton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalDependencies {
  late SharedPreferencesService preferencesService;

  factory GlobalDependencies() {
    return _instance;
  }

  static final GlobalDependencies _instance = GlobalDependencies._internal();

  GlobalDependencies._internal();

  Future<void> init({
    required LoggerSettings settings,
  }) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    preferencesService = SharedPreferencesService(sharedPreferences);

    final deviceInfoSingleton = DeviceInfoSingleton();

    await deviceInfoSingleton.init();

    FlutterLogSingleton().init(settings: settings);
  }
}
