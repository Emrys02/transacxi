import '../models/transaction.dart';

class TransactionController {
  TransactionController._internal();
  static final _initialize = TransactionController._internal();
  factory TransactionController() => _initialize;

  int? _amount;
  String? _txRef;
  String? _accessCode;
  String? _receiverUsername;
  final String _currency = "NGN";
  Provider? _provider;
  TransactionType? _transactionType;
  String? _destination;
  String? _accountNumber;
  String? _flutterwaveCode;
  String? _paystackCode;
  double _flutterwaveAmount = 0;
  double _paystackAmount = 0;

  int get amount {
    return _amount ?? 0;
  }

  String get txRef {
    return _txRef ?? "";
  }

  String get accessCode {
    return _accessCode ?? "";
  }

  String get receiverUsername {
    return _receiverUsername ?? "";
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

  double get flutterwaveAmount {
    return _flutterwaveAmount;
  }

  double get paystackAmount {
    return _paystackAmount;
  }

  Provider? get provider {
    return _provider;
  }

  TransactionType? get transactionType {
    return _transactionType;
  }

  set updateTxRef(String value) {
    _txRef = value;
  }

  set updateAccessCode(String value) {
    _accessCode = value;
  }

  set updateReceiverUsername(String value) {
    _receiverUsername = value;
  }

  set updateProvider(Provider value) {
    _provider = value;
  }

  set updateTransactionType(TransactionType value) {
    _transactionType = value;
  }

  set updateDestinaiton(String value) {
    _destination = value;
  }

  set updateAccountNumber(String value) {
    _accountNumber = value;
  }

  set updateFlutterwaveCode(String? value) {
    _flutterwaveCode = value;
  }

  set updatePaystackCode(String? value) {
    _paystackCode = value;
  }

  set updatePaystackAmount(double value) {
    _paystackAmount = value;
  }

  set updateFlutterwaveAmount(double value) {
    _flutterwaveAmount = value;
  }

  void updateAmount(String? value) {
    if (value == null) return;
    _amount = int.parse(value);
  }

  void dispose() {
    _amount = null;
    _txRef = null;
    _transactionType = null;
    _provider = null;
    _destination = null;
    _accessCode = null;
    _flutterwaveAmount = 0;
    _paystackAmount = 0;
    _flutterwaveCode = null;
    _paystackCode = null;
    _accountNumber = null;
    _receiverUsername = null;
  }
}
