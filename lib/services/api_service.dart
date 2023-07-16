import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:transacxi/extensions/num_extension.dart';

import '../constants/constants.dart';
import '../helpers/global_variables.dart';

class ApiService {
  ApiService._();

  static Dio _flutterwaveInit() {
    final dio = Dio();
    dio.options = BaseOptions(
      baseUrl: "https://api.flutterwave.com/v3",
      connectTimeout: 20.seconds(),
      headers: {"Authoriazation": "Bearer $kFlutterwaveSecretKey"},
      receiveTimeout: 30.seconds(),
      responseType: ResponseType.json,
      sendTimeout: 20.seconds(),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log(options.path);
          log(options.data.toString());
        },
        onResponse: (e, handler) {
          log(e.statusCode.toString());
          log(e.statusMessage.toString());
          log(e.data.toString());
        },
      ),
    );
    return dio;
  }

  static Dio _paystackInit() {
    final dio = Dio();
    dio.options = BaseOptions(
      baseUrl: "https://api.paystack.co",
      connectTimeout: 20.seconds(),
      headers: {"Authoriazation": "Bearer $kPaystackSecretKey"},
      receiveTimeout: 30.seconds(),
      responseType: ResponseType.json,
      sendTimeout: 20.seconds(),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log(options.path);
          log(options.data.toString());
        },
        onResponse: (e, handler) {
          log(e.statusCode.toString());
          log(e.statusMessage.toString());
          log(e.data.toString());
        },
      ),
    );
    return dio;
  }

  static Future<void> retrieveBanksList() async {
    final ref = await _flutterwaveInit().get("/banks/NG");
    for (var bank in ref.data["data"]) {
      banks.add(bank["name"]);
    }
  }
}
