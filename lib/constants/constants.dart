import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final _secretKey = Key.fromUtf8('19e012e7a1e7f123928a110e7b97ea6f');
final _initializationValue = IV.fromUtf8('531ff2e01572cb2c1105eae4172b8522');

final _encrypter = Encrypter(AES(_secretKey));

String kFlutterwavePublicKey = _encrypter.decrypt(Encrypted(Uint8List(json.decode(dotenv.get("flutterWavePublicKey")))), iv: _initializationValue);
String kFlutterwaveSecretKey = _encrypter.decrypt(Encrypted(Uint8List(json.decode(dotenv.get("flutterWaveSecretKey")))), iv: _initializationValue);
String kPaystackPublicKey = _encrypter.decrypt(Encrypted(Uint8List(json.decode(dotenv.get("PaystackPublicKey")))), iv: _initializationValue);
String kPaystackSecretKey = _encrypter.decrypt(Encrypted(Uint8List(json.decode(dotenv.get("PaystackSecretKey")))), iv: _initializationValue);
