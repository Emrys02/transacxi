import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final _secretKey = Key.fromUtf8('19e012e7a1e7f123928a110e7b97ea6f');
final _initializationValue = IV.fromUtf8('531ff2e01572cb2c');

final _encrypter = Encrypter(AES(_secretKey));

String kFlutterwavePublicKey =
    _encrypter.decrypt(Encrypted(Uint8List.fromList(_convertList(json.decode(dotenv.get("flutterWavePublicKey"))))), iv: _initializationValue);
String kFlutterwaveSecretKey = dotenv.get("flutterWaveSecretKey");
String kPaystackPublicKey =
    _encrypter.decrypt(Encrypted(Uint8List.fromList(_convertList(json.decode(dotenv.get("PaystackPublicKey"))))), iv: _initializationValue);
String kPaystackSecretKey =
    _encrypter.decrypt(Encrypted(Uint8List.fromList(_convertList(json.decode(dotenv.get("PaystackSecretKey"))))), iv: _initializationValue);

List<int> _convertList(List data) {
  final temp = <int>[];
  for (var num in data) {
    temp.add(num);
  }
  log(temp.length.toString());
  return temp;
}
