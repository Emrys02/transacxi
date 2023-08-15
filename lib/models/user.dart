import 'transaction.dart';

class User {
  String id;
  String firstname;
  String lastname;
  String fullname;
  String email;
  String accountNumber;
  String profileImage;
  double balance;
  double flutterwaveBalance;
  double paystackBalance;
  List<Transaction> transactions;
  User({
    required this.id,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.fullname,
    required this.accountNumber,
    required this.balance,
    required this.flutterwaveBalance,
    required this.paystackBalance,
    this.transactions = const [],
    this.profileImage = "",
  });

  static User fromMap(String id, Map json) {
    return User(
        id: id,
        email: json["email"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        fullname: json["fullname"],
        accountNumber: json["accountNumber"],
        balance: json["balance"],
        flutterwaveBalance: json["flutterwaveBalance"] ?? 0,
        paystackBalance: json["paystackBalance"] ?? 0,
        profileImage: json["profileImage"] ?? "");
  }
}
