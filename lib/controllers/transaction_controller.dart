import '../models/transaction.dart';

class TransactionController {
  TransactionController._internal();
  static final _initialize = TransactionController._internal();
  factory TransactionController() => _initialize;

  String? _id;
  int? _amount = 0;
  String? _txRef = "";
  final String _currency = "NG";
  Provider? _provider;
  TransactionType? _transactionType;

  String get id {
    return _id ?? "";
  }

  int get amount {
    return _amount ?? 0;
  }

  String get txRef {
    return _txRef ?? "";
  }

  String get currency {
    return _currency;
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

  set updateTxId(String value) {
    _id = value;
  }

  set updateProvider(Provider value) {
    _provider = value;
  }

  set updateTransactionType(TransactionType value) {
    _transactionType = value;
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
  }
}
