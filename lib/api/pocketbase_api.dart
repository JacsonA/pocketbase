import 'package:flutter/foundation.dart';
import 'package:pocketbase/pocketbase.dart';

class PocketBaseAPI {
  // pr emul android fo utiliser 10.0.2.2
  // sinon web/ios c'est 127.0.0.1 normal
  static final String _baseUrl = defaultTargetPlatform == TargetPlatform.android
      ? 'http://10.0.2.2:8090'
      : 'http://127.0.0.1:8090';

  // inst unique pr pas recreer chake fois
  static final PocketBaseAPI _instance = PocketBaseAPI._internal();

  factory PocketBaseAPI() => _instance;

  final PocketBase client;

  PocketBaseAPI._internal() : client = PocketBase(_baseUrl);
}
