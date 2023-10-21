import 'dart:async';

abstract class StorageService {
  FutureOr<dynamic> get(String key);

  FutureOr<void> set(String key, value);

  FutureOr<void> delete(String key);
}
