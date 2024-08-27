import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfoSingleton {
  late DeviceInfoPlugin _deviceInfoPlugin;
  late PackageInfo _packageInfo;

  factory DeviceInfoSingleton() {
    return _instance;
  }

  static final DeviceInfoSingleton _instance = DeviceInfoSingleton._internal();

  DeviceInfoSingleton._internal();

  Future<void> init({
    required bool initNetworkInfo,
  }) async {
    _deviceInfoPlugin = DeviceInfoPlugin();
    _packageInfo = await PackageInfo.fromPlatform();
    if (Platform.isIOS) {
      final iOSInfo = await _deviceInfoPlugin.iosInfo;
      _platform = 'iOS';
      _model = iOSInfo.utsname.machine;
      _systemName = iOSInfo.systemName;
      _systemVersion = iOSInfo.systemVersion;
      _version = _packageInfo.version;
      _buildNumber = _packageInfo.buildNumber;
    }
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfoPlugin.iosInfo;
      _platform = 'Android';
      _model = androidInfo.model;
      _systemName = androidInfo.systemName;
      _systemVersion = androidInfo.systemVersion;
      _version = _packageInfo.version;
      _buildNumber = _packageInfo.buildNumber;
    }
  }

  String? _platform;
  String? _model;
  String? _systemName;
  String? _systemVersion;
  String? _version;
  String? _buildNumber;

  String get platform {
    if (_platform != null) {
      return _platform!;
    }
    throw Exception(
      'This field has not been initialized. Be sure to call DeviceInfoSingleton.init() before accessing this field',
    );
  }

  String get model {
    if (_model != null) {
      return _model!;
    }
    throw Exception(
      'This field has not been initialized. Be sure to call DeviceInfoSingleton.init() before accessing this field',
    );
  }

  String get systemName {
    if (_systemName != null) {
      return _systemName!;
    }
    throw Exception(
      'This field has not been initialized. Be sure to call DeviceInfoSingleton.init() before accessing this field',
    );
  }

  String get systemVersion {
    if (_systemVersion != null) {
      return _systemVersion!;
    }
    throw Exception(
      'This field has not been initialized. Be sure to call DeviceInfoSingleton.init() before accessing this field',
    );
  }

  String get version {
    if (_version != null) {
      return _version!;
    }
    throw Exception(
      'This field has not been initialized. Be sure to call DeviceInfoSingleton.init() before accessing this field',
    );
  }

  String get buildNumber {
    if (_buildNumber != null) {
      return _buildNumber!;
    }
    throw Exception(
      'This field has not been initialized. Be sure to call DeviceInfoSingleton.init() before accessing this field',
    );
  }
}
