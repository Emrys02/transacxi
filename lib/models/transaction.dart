enum Provider {
  flutterwave,
  paystack;

  factory Provider.fromString(String value) {
    return Provider.values.firstWhere((element) => element.name == value);
  }
}

enum TransactionType {
  credit,
  debit;

  factory TransactionType.fromString(String value) {
    return TransactionType.values.firstWhere((element) => element.name == value);
  }
}

class Transaction {
  String id;
  TransactionType type;
  dynamic amount;
  String? receiver;
  Provider provider;

  Transaction({required this.id, required this.type, required this.amount, required this.provider, this.receiver});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    print(json);
    return Transaction(
      id: json.keys.first,
      type: TransactionType.fromString(json[json.keys.first]?["type"]),
      amount: json[json.keys.first]?["amount"],
      provider: Provider.fromString(json[json.keys.first]?["provider"]),
      receiver: json[json.keys.first]?["receiver"],
    );
  }
}
