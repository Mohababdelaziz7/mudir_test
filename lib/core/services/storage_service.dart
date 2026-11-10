abstract class StorageService {
  Future<void> setString(String key, String value);
  Future<String?> getString(String key);
  Future<void> setStringSet(String key, Set<String> values);
  Future<Set<String>> getStringSet(String key);
  Future<void> remove(String key);
  Future<void> clear();
}

class InMemoryStorageService implements StorageService {
  final Map<String, dynamic> _store = {};

  @override
  Future<void> setString(String key, String value) async {
    _store[key] = value;
  }

  @override
  Future<String?> getString(String key) async {
    return _store[key] as String?;
  }

  @override
  Future<void> setStringSet(String key, Set<String> values) async {
    _store[key] = Set<String>.from(values);
  }

  @override
  Future<Set<String>> getStringSet(String key) async {
    final val = _store[key];
    if (val is Set<String>) return Set<String>.from(val);
    if (val is Iterable<String>) return val.toSet();
    return {};
  }

  @override
  Future<void> remove(String key) async {
    _store.remove(key);
  }

  @override
  Future<void> clear() async {
    _store.clear();
  }
}
