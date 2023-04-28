import 'dart:html';
import 'dart:indexed_db';
import 'dart:js' as js;
import 'package:hive_built_value/hive_built_value.dart';
import 'package:hive_built_value/src/backend/js/storage_backend_js.dart';
import 'package:hive_built_value/src/backend/storage_backend.dart';

/// Opens IndexedDB databases
class BackendManager implements BackendManagerInterface {
  IdbFactory? get indexedDB => js.context.hasProperty('window')
      ? window.indexedDB
      : WorkerGlobalScope.instance.indexedDB;

  @override
  Future<StorageBackend> open(
      String name, String? path, bool crashRecovery, HiveCipher? cipher) async {
    var db = await indexedDB!.open(name, version: 1, onUpgradeNeeded: (e) {
      var db = e.target.result as Database;
      if (!db.objectStoreNames!.contains('box')) {
        db.createObjectStore('box');
      }
    });

    return StorageBackendJs(db, cipher);
  }

  @override
  Future<void> deleteBox(String name, String? path) {
    return indexedDB!.deleteDatabase(name);
  }

  @override
  Future<bool> boxExists(String name, String? path) async {
    // https://stackoverflow.com/a/17473952
    try {
      var exists = true;
      await indexedDB!.open(name, version: 1, onUpgradeNeeded: (e) {
        e.target.transaction!.abort();
        exists = false;
      });
      return exists;
    } catch (error) {
      return false;
    }
  }
}
