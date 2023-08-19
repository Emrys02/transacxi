import 'transaction.dart';

class User {
  String id;
  String firstname;
  String lastname;
  String fullname;
  String email;
  String username;
  String profileImage;
  String? pin;
  double balance;
  int flutterwaveBalance;
  int paystackBalance;
  Map<String, List<Transaction>> transactions;
  User({
    required this.id,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.fullname,
    required this.username,
    required this.balance,
    required this.flutterwaveBalance,
    required this.paystackBalance,
    required this.transactions,
    this.profileImage = "",
    this.pin,
  });

  static User fromMap(String id, Map json) {
    return User(
        id: id,
        email: json["email"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        fullname: json["fullname"],
        username: json["username"],
        balance: json["balance"],
        flutterwaveBalance: json["flutterwaveBalance"] ?? 0,
        paystackBalance: json["paystackBalance"] ?? 0,
        pin: json["pin"],
        transactions: {},
        profileImage: json["profileImage"] ?? "");
  }
}
