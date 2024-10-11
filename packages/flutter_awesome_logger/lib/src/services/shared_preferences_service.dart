import 'package:shared_preferences/shared_preferences.dart';

const _prefix = 'FLUTTER_LOGGER_';

class SharedPreferencesService {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesService(this._sharedPreferences);

  setString(String key, String value) async {
    await _sharedPreferences.setString('$_prefix$key', value);
  }

  String? getString(String key) {
    return _sharedPreferences.getString('$_prefix$key');
  }

  Future<bool> clearValue(String key) async => _sharedPreferences.remove(key);
}

const proxyName = 'PROXY';
