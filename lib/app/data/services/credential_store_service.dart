import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:snypix_flutter/app/data/models/credential_model.dart';

class CredentialStoreService extends GetxService {
  static const storageKey = 'crendential';
  final _storage = const FlutterSecureStorage();

  Future<CredentialModel> load() async {
    final json = await _storage.read(key: storageKey);
    if (json == null) {
      return CredentialModel.empty();
    }
    return CredentialModel.fromJson(jsonDecode(json));
  }

  Future<void> store(CredentialModel credential) async {
    await _storage.write(key: storageKey, value: jsonEncode(credential));
  }

  Future<void> clear() async {
    await _storage.delete(key: storageKey);
  }
}
