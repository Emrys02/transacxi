import 'dart:developer';

import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final _secretKey = Key.fromUtf8('19e012e7a1e7f123928a110e7b97ea6f');
final _initializationValue = IV.fromUtf8('531ff2e01572cb2c');

final _encrypter = Encrypter(AES(_secretKey));

String kFlutterwavePublicKey = dotenv.get("flutterWavePublicKey");
String kFlutterwaveSecretKey = dotenv.get("flutterWaveSecretKey");
String kPaystackPublicKey = dotenv.get("PaystackPublicKey");
String kPaystackSecretKey = dotenv.get("PaystackSecretKey");

List<int> _convertList(List data) {
  final temp = <int>[];
  for (var num in data) {
    temp.add(num);
  }
  log(temp.length.toString());
  return temp;
}
