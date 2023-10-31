import 'dart:async';

import 'package:hive/hive.dart';
import 'package:keracars_app/core/storage/storage_service.dart';

class HiveStorageService implements StorageService {
  final Box _box;

  HiveStorageService({required Box box}) : _box = box;

  @override
  FutureOr<dynamic> get(String key) async {
    return await _box.get(key);
  }

  @override
  FutureOr<void> set(String key, value) async {
    return await _box.put(key, value);
  }

  @override
  FutureOr<void> delete(String key) async {
    return await _box.delete(key);
  }
}
