import '../models/transaction.dart';

class TransactionController {
  TransactionController._internal();
  static final _initialize = TransactionController._internal();
  factory TransactionController() => _initialize;

  int? _amount;
  String? _txRef;
  String? accessCode;
  String? _receiverUsername;
  String? _receiverId;
  final String _currency = "NGN";
  Provider? provider;
  TransactionType? transactionType;
  String? _destination;
  String? _accountNumber;
  String? _flutterwaveCode;
  String? _paystackCode;
  int flutterwaveAmount = 0;
  int paystackAmount = 0;

  int get amount {
    return _amount ?? 0;
  }

  String get txRef {
    return _txRef ?? "";
  }

  String get receiverUsername {
    return _receiverUsername ?? "";
  }

  String get receiverId {
    return _receiverId ?? "";
  }

  String get currency {
    return _currency;
  }

  String get destination {
    return _destination ?? "";
  }

  String get accountNumber {
    return _accountNumber ?? "";
  }

  String get flutterwaveCode {
    return _flutterwaveCode ?? "";
  }

  String get paystackCode {
    return _paystackCode ?? "";
  }

  set updateTxRef(String value) {
    _txRef = value;
  }

  set receiverUsername(String value) {
    _receiverUsername = value;
  }

  set receiverId(String value) {
    _receiverId = value;
  }

  set destinaiton(String value) {
    _destination = value;
  }

  set accountNumber(String value) {
    _accountNumber = value;
  }

  set flutterwaveCode(String? value) {
    _flutterwaveCode = value;
  }

  set paystackCode(String? value) {
    _paystackCode = value;
  }

  set updateAmount(String? value) {
    if (value == null) return;
    _amount = int.parse(value);
  }

  void dispose() {
    _amount = null;
    _txRef = null;
    transactionType = null;
    provider = null;
    _destination = null;
    accessCode = null;
    flutterwaveAmount = 0;
    paystackAmount = 0;
    _flutterwaveCode = null;
    _paystackCode = null;
    _accountNumber = null;
    _receiverUsername = null;
    _receiverId = null;
  }
}
