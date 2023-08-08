import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../controllers/transaction_controller.dart';
import '../controllers/user_controller.dart';
import '../extensions/date_extension.dart';

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
      await saveTransactions();
    } on Error catch (e) {
      log(e.toString(), error: e.runtimeType, time: DateTime.now(), name: e.runtimeType.toString());
      throw "An error occured";
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> transactions = _firestore.collection(_userController.currentUser.id).snapshots();
}
