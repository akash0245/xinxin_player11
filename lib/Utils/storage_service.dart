import 'package:get_storage/get_storage.dart';

class StorageService {

  final _storage = GetStorage();

  /// Save data
  void write(String key, dynamic value) {
    _storage.write(key, value);
    // debugPrint('isFirstOpen Storage when key $key: ${_storage.read(StringHelper.isFirstOpen)}');
  }

  /// Read data with default value if key is not found
  T read<T>(String key, {T? defaultValue}) {
    return _storage.read<T>(key) ?? defaultValue as T;
  }

  /// Remove a key
  void remove(String key) {
    _storage.remove(key);
  }

  /// Clear all storage
  void clear() {
    _storage.erase();
  }
}
