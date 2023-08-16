import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:transacxi/models/bank.dart';

import '../constants/constants.dart';
import '../controllers/transaction_controller.dart';
import '../extensions/num_extension.dart';
import '../helpers/global_variables.dart';

class ApiService {
  ApiService._();

  static final _transactionController = TransactionController();

  static Dio _flutterwaveInit() {
    final dio = Dio();
    dio.options = BaseOptions(
      baseUrl: "https://api.flutterwave.com/v3",
      headers: {"Authorization": "Bearer $kFlutterwaveSecretKey"},
      connectTimeout: 15.seconds(),
      receiveTimeout: 15.seconds(),
      sendTimeout: 15.seconds(),
      responseType: ResponseType.json,
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log(options.path);
          log(options.data.toString());
          return handler.next(options);
        },
        onResponse: (response, handler) {
          log(response.statusCode.toString());
          log(response.statusMessage.toString());
          log(response.data.toString());
          return handler.next(response);
        },
        onError: (e, handler) {
          log(e.error.toString());
          log(e.message.toString());
          log(e.response.toString());
          return handler.next(e);
        },
      ),
    );
    return dio;
  }

  static Dio _paystackInit() {
    final dio = Dio();
    dio.options = BaseOptions(
      baseUrl: "https://api.paystack.co",
      headers: {"Authorization": "Bearer $kPaystackSecretKey"},
      connectTimeout: 15.seconds(),
      receiveTimeout: 15.seconds(),
      sendTimeout: 15.seconds(),
      responseType: ResponseType.json,
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log(options.path);
          log("data: ${options.data}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          log(response.statusCode.toString());
          log(response.statusMessage.toString());
          log(response.data.toString());
          return handler.next(response);
        },
        onError: (e, handler) {
          log(e.error.toString());
          log(e.message.toString());
          log(e.response.toString());
          return handler.next(e);
        },
      ),
    );
    return dio;
  }

  static Future<void> retrieveFlutterwaveBanksList() async {
    final ref = await _flutterwaveInit().get("/banks/NG");
    for (var bank in ref.data["data"]) {
      if (banks.any((element) => element.name == bank["name"])) {
        final index = banks.indexWhere((element) => element.name == bank["name"]);
        final data = banks[index];
        banks.removeAt(index);
        data.flutterwaveCode = bank["code"].toString();
        banks.insert(index, data);
      } else {
        banks.add(Bank(name: bank["name"], flutterwaveCode: bank["code"].toString()));
      }
    }
    banks.sort((a, b) => a.name.compareTo(b.name));
  }

  static Future<void> retrievePaystackBanksList() async {
    final ref = await _paystackInit().get("/bank", data: {"country": "nigeria", "perPage": 100, "currency": "NGN"});
    for (var bank in ref.data["data"]) {
      if (banks.any((element) => element.name == bank["name"])) {
        final index = banks.indexWhere((element) => element.name == bank["name"]);
        final data = banks[index];
        banks.removeAt(index);
        data.paystackCode = bank["code"].toString();
        banks.insert(index, data);
      } else {
        banks.add(Bank(name: bank["name"], paystackCode: bank["code"].toString()));
      }
    }
    banks.sort((a, b) => a.name.compareTo(b.name));
  }

  static Future<void> initializePaystack({required String email, required int amount}) async {
    final payload = {"email": email, "amount": amount};
    final ref = await _paystackInit().post("/transaction/initialize", data: jsonEncode(payload));
    log(ref.data.toString());
    _transactionController.updateTxRef = ref.data["data"]["reference"];
    _transactionController.updateAccessCode = ref.data["data"]["access_code"];
  }

  static Future<String> paystackVerifyAccount() async {
    final ref = await _paystackInit().get("/bank/resolve",
        data: {"account_number": int.parse(_transactionController.accountNumber), "bank_code": int.parse(_transactionController.paystackCode)});
    return ref.data["data"]["account_name"];
  }

  static Future<String> flutterwaveVerifyAccount() async {
    final ref = await _flutterwaveInit().get("/accounts/resolve",
        data: {"account_number": int.parse(_transactionController.accountNumber), "account_code": int.parse(_transactionController.flutterwaveCode)});
    return ref.data["data"]["account_name"];
  }
}
