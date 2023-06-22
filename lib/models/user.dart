class User {
  String id;
  String firstname;
  String lastname;
  String fullname;
  String email;
  String accountNumber;
  User({required this.id, required this.email, required this.firstname, required this.lastname, required this.fullname, required this.accountNumber});

  static User fromMap(String id, Map json) {
    return User(
      id: id,
      email: json["email"],
      firstname: json["firstname"],
      lastname: json["lastname"],
      fullname: json["fullname"],
      accountNumber: json["accountNumber"],
    );
  }
}
