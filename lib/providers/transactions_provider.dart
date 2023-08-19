import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

import '../controllers/transaction_controller.dart';
import '../controllers/user_controller.dart';
import '../extensions/date_extension.dart';
import '../handlers/balance_handler.dart';
import '../models/transaction.dart';

class TransactionProvider {
  TransactionProvider._();

  static final _firestore = FirebaseFirestore.instance;
  static final _database = FirebaseDatabase.instance;
  static final _userController = UserController();
  static final _transactionController = TransactionController();

  static Future<void> saveCreditTransactions() async {
    try {
      if ((await _firestore.collection(_userController.currentUser.id).doc(DateTime.now().date()).get()).exists) {
        await _firestore.collection(_userController.currentUser.id).doc(DateTime.now().date()).update({
          _transactionController.txRef: {
            "amount": _transactionController.amount,
            "type": _transactionController.transactionType!.name,
            "provider": _transactionController.provider!.name,
            "currency": _transactionController.currency,
            "accessCode": _transactionController.accessCode,
          }
        });
      } else {
        await _firestore.collection(_userController.currentUser.id).doc(DateTime.now().date()).set({
          _transactionController.txRef: {
            "amount": _transactionController.amount,
            "type": _transactionController.transactionType!.name,
            "provider": _transactionController.provider!.name,
            "currency": _transactionController.currency,
            "accessCode": _transactionController.accessCode,
          }
        });
      }
    } on FirebaseException catch (e) {
      log(e.toString(), error: FirebaseException, time: DateTime.now(), name: e.runtimeType.toString());
      throw e.message.toString();
    } on TimeoutException catch (e) {
      log(e.toString(), error: TimeoutException, time: DateTime.now(), name: e.runtimeType.toString());
      await saveCreditTransactions();
    } on Error catch (e) {
      log(e.toString(), error: e.runtimeType, time: DateTime.now(), name: e.runtimeType.toString());
      throw "An error occured";
    }
  }

  static Future<String> verifyWalletIdentity() async {
    try {
      final data = await _database.ref("accounts").child(_transactionController.receiverUsername).get();
      if (data.value == null) throw "Not found";
      final name = await _database.ref("users").child(data.value.toString()).child("fullname").get();
      _transactionController.receiverId = data.value.toString();
      log(data.value.toString());
      return name.value.toString();
    } on FirebaseException catch (e) {
      log(e.toString(), error: FirebaseException, time: DateTime.now(), name: e.runtimeType.toString());
      throw e.message.toString();
    } on TimeoutException catch (e) {
      log(e.toString(), error: TimeoutException, time: DateTime.now(), name: e.runtimeType.toString());
      throw e.message.toString();
    } on Error catch (e) {
      log(e.toString(), error: e.runtimeType, time: DateTime.now(), name: e.runtimeType.toString());
      throw "An error occured";
    }
  }

  static Future<void> creditUser() async {
    try {
      await _database
          .ref("users")
          .child(_userController.currentUser.id)
          .child("balance")
          .set(_userController.currentUser.balance + _transactionController.amount);
      if (_transactionController.provider == Provider.flutterwave) {
        await _database
            .ref("users")
            .child(_userController.currentUser.id)
            .child("flutterwaveBalance")
            .set(_userController.currentUser.flutterwaveBalance + _transactionController.amount);
      }
      if (_transactionController.provider == Provider.paystack) {
        await _database
            .ref("users")
            .child(_userController.currentUser.id)
            .child("paystackBalance")
            .set(_userController.currentUser.paystackBalance + _transactionController.amount);
      }
      _userController.currentUser.balance = _userController.currentUser.balance + _transactionController.amount;
    } on FirebaseException catch (e) {
      log(e.toString(), error: FirebaseException, time: DateTime.now(), name: e.runtimeType.toString());
      throw e.message.toString();
    } on TimeoutException catch (e) {
      log(e.toString(), error: TimeoutException, time: DateTime.now(), name: e.runtimeType.toString());
      await creditUser();
    } on Error catch (e) {
      log(e.toString(), error: e.runtimeType, time: DateTime.now(), name: e.runtimeType.toString());
      throw "An error occured";
    }
  }

  static Future<void> creditReceiver() async {
    try {
      log("retrieving receivers flutterwave balance");
      log(_transactionController.receiverId);
      log(_userController.currentUser.id);
      log((await _database.ref("users").child(_transactionController.receiverId).child("balance").get()).value.toString());
      var receiverFlutterwaveBalance =
          (await _database.ref("users").child(_transactionController.receiverId).child("flutterwaveBalance").get()).value as int? ?? 0;
      log("$receiverFlutterwaveBalance");
      log("retrieving receivers paystack balance");
      var receiverPaystackBalance = (await _database.ref("users").child(_transactionController.receiverId).child("paystackBalance").get()).value as int? ?? 0;
      log("$receiverPaystackBalance");
      log("retrieving receivers balance");
      var receiverBalance = (await _database.ref("users").child(_transactionController.receiverId).child("balance").get()).value as double;
      log("$receiverBalance");
      receiverBalance += _transactionController.flutterwaveAmount + _transactionController.paystackAmount;
      receiverFlutterwaveBalance += _transactionController.flutterwaveAmount;
      receiverPaystackBalance += _transactionController.paystackAmount;
      log("updated balances\nreceiverBalance $receiverBalance\nreceiverFlutterwaveBalance $receiverFlutterwaveBalance\nreceiverPaystackBalance $receiverPaystackBalance");
      await _database
          .ref("users")
          .child(_transactionController.receiverId)
          .update({"balance": receiverBalance, "flutterwaveBalance": receiverFlutterwaveBalance, "paystackBalance": receiverPaystackBalance});
      log("credited receiver");
    } on FirebaseException catch (e) {
      log(e.toString(), error: FirebaseException, time: DateTime.now(), name: e.runtimeType.toString());
      throw e.message.toString();
    } on TimeoutException catch (e) {
      log(e.toString(), error: TimeoutException, time: DateTime.now(), name: e.runtimeType.toString());
      throw e.message.toString();
    } on Error catch (e) {
      log(e.toString(), error: e.runtimeType, time: DateTime.now(), name: e.runtimeType.toString());
      throw "An error occured";
    }
  }

  static Future<void> saveTransactionForReceiver() async {
    try {
      if ((await _firestore.collection(_transactionController.receiverId).doc(DateTime.now().date()).get()).exists) {
        await _firestore.collection(_transactionController.receiverId).doc(DateTime.now().date()).update({
          _transactionController.txRef: {
            "amount": _transactionController.amount,
            "type": "credit",
            "provider": _transactionController.provider?.name ?? "wallet",
            "currency": _transactionController.currency,
            "accessCode": _transactionController.accessCode,
          }
        });
      } else {
        await _firestore.collection(_transactionController.receiverId).doc(DateTime.now().date()).set({
          _transactionController.txRef: {
            "amount": _transactionController.amount,
            "type": "credit",
            "provider": _transactionController.provider?.name ?? "wallet",
            "currency": _transactionController.currency,
            "accessCode": _transactionController.accessCode,
          }
        });
      }
    } on FirebaseException catch (e) {
      log(e.toString(), error: FirebaseException, time: DateTime.now(), name: e.runtimeType.toString());
      throw e.message.toString();
    } on TimeoutException catch (e) {
      log(e.toString(), error: TimeoutException, time: DateTime.now(), name: e.runtimeType.toString());
      throw e.message.toString();
    } on Error catch (e) {
      log(e.toString(), error: e.runtimeType, time: DateTime.now(), name: e.runtimeType.toString());
      throw "An error occured";
    }
  }

  static Future<void> debitUser() async {
    try {
      final balance = _userController.currentUser.balance - (_transactionController.amount);
      final flutterwaveBalance = _userController.currentUser.flutterwaveBalance - _transactionController.flutterwaveAmount;
      final paystackBalance = _userController.currentUser.paystackBalance - _transactionController.paystackAmount;
      await _database
          .ref("users")
          .child(_userController.currentUser.id)
          .update({"balance": balance, "flutterwaveBalance": flutterwaveBalance, "paystackBalance": paystackBalance});
      if ((await _firestore.collection(_userController.currentUser.id).doc(DateTime.now().date()).get()).exists) {
        await _firestore.collection(_userController.currentUser.id).doc(DateTime.now().date()).update({
          _transactionController.txRef: {
            "amount": _transactionController.amount,
            "type": _transactionController.transactionType!.name,
            "provider": _transactionController.provider?.name ?? "wallet",
            "currency": _transactionController.currency,
            "accessCode": _transactionController.accessCode,
          }
        });
      } else {
        await _firestore.collection(_userController.currentUser.id).doc(DateTime.now().date()).set({
          _transactionController.txRef: {
            "amount": _transactionController.amount,
            "type": _transactionController.transactionType!.name,
            "provider": _transactionController.provider?.name ?? "wallet",
            "currency": _transactionController.currency,
            "accessCode": _transactionController.accessCode,
          }
        });
      }
      BalanceHandler().updateBalance(_userController.currentUser.balance);
    } on FirebaseException catch (e) {
      log(e.toString(), error: FirebaseException, time: DateTime.now(), name: e.runtimeType.toString());
      throw e.message.toString();
    } on TimeoutException catch (e) {
      log(e.toString(), error: TimeoutException, time: DateTime.now(), name: e.runtimeType.toString());
      throw e.message.toString();
    } on Error catch (e) {
      log(e.toString(), error: e.runtimeType, time: DateTime.now(), name: e.runtimeType.toString());
      throw "An error occured";
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> transactions = _firestore.collection(_userController.currentUser.id).snapshots();
}
