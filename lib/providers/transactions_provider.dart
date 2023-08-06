import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../controllers/transaction_controller.dart';
import '../controllers/user_controller.dart';

class TransactionProvider {
  TransactionProvider._();
  static final _firestore = FirebaseFirestore.instance;
  static final _userController = UserController();
  static final _transactionController = TransactionController();

  static Future<void> retrieveTransactions() async {
    try {
      final data = await _firestore.collection("transactions").doc(_userController.currentUser.id).get();
      data.data();
    } on FirebaseException catch (e) {
      log(e.toString(), error: FirebaseException, time: DateTime.now(), name: e.runtimeType.toString());
      throw e.message.toString();
    } on TimeoutException catch (e) {
      log(e.toString(), error: TimeoutException, time: DateTime.now(), name: e.runtimeType.toString());
      throw "Request Timeout";
    } on Error catch (e) {
      log(e.toString(), error: e.runtimeType, time: DateTime.now(), name: e.runtimeType.toString());
      throw "An error occured";
    }
  }

  static Future<void> saveTransactions() async {
    try {
      await _firestore
          .collection("transactions")
          .doc(_userController.currentUser.id)
          .collection(DateTime.now().toIso8601String())
          .doc(_transactionController.id)
          .set({
        "reference": _transactionController.txRef,
        "amount": _transactionController.amount,
        "type": _transactionController.transactionType!.name,
        "provider": _transactionController.provider!.name,
        "currency": _transactionController.currency,
      });
    } on FirebaseException catch (e) {
      log(e.toString(), error: FirebaseException, time: DateTime.now(), name: e.runtimeType.toString());
      throw e.message.toString();
    } on TimeoutException catch (e) {
      log(e.toString(), error: TimeoutException, time: DateTime.now(), name: e.runtimeType.toString());
      await saveTransactions();
    } on Error catch (e) {
      log(e.toString(), error: e.runtimeType, time: DateTime.now(), name: e.runtimeType.toString());
      throw "An error occured";
    }
  }
}
