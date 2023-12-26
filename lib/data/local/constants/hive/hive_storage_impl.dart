import 'package:chat_app/data/local/constants/hive/app_local_storage.dart';
import 'package:hive/hive.dart';

class HiveStorageImpl implements AppLocalStorage {
  final Box<dynamic> _box;

  HiveStorageImpl(this._box);

  @override
  Future<void> clear() async {
    await _box.clear();
  }

  @override
  Future<void> remove(String key) async {
    await _box.delete(key);
  }

  @override
  Future<void> saveBool(String key, bool value) async {
    await _box.put(key, value);
  }

  @override
  Future<void> saveDouble(String key, double value) async {
    await _box.put(key, value);
  }

  @override
  Future<void> saveInt(String key, int value) async {
    await _box.put(key, value);
  }

  @override
  Future<void> saveString(String key, String value) async {
    await _box.put(key, value);
  }

  @override
  Future<void> saveStringList(String key, List<String> value) async {
    await _box.put(key, value);
  }

  @override
  bool? getBool(String key) {
    return _box.get(key);
  }

  @override
  double? getDouble(String key) {
    return _box.get(key);
  }

  @override
  int? getInt(String key) {
    return _box.get(key);
  }

  @override
  List<String>? getListString(String key) {
    return _box.get(key);
  }

  @override
  String? getString(String key) {
    return _box.get(key);
  }
}
