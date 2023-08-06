import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, FirebaseAuthException, FirebaseException;
import 'package:transacxi/controllers/user_controller.dart';

import '../controllers/new_user_controller.dart';
import '../controllers/transaction_controller.dart';

class AuthProvider {
  AuthProvider._();
  static final _newUserController = NewUserController();
  static final _firebaseAuth = FirebaseAuth.instance;

  static bool completedAction = false;

  static Future<String> login() async {
    try {
      final ref = await _firebaseAuth.signInWithEmailAndPassword(email: _newUserController.email, password: _newUserController.password);
      completedAction = true;
      return ref.user!.uid;
    } on FirebaseAuthException catch (e) {
      log(e.toString(), error: FirebaseAuthException, time: DateTime.now(), name: "login error");
      throw e.message.toString();
    } on FirebaseException catch (e) {
      log(e.toString(), error: FirebaseException, time: DateTime.now(), name: "login error");
      throw e.message.toString();
    } on TimeoutException catch (e) {
      log(e.toString(), error: TimeoutException, time: DateTime.now(), name: "login error");
      throw "Request Timeout";
    } on Error catch (e) {
      log(e.toString(), error: e.runtimeType, time: DateTime.now(), name: "login error");
      throw "An error occured";
    }
  }

  static Future<String> createUser() async {
    try {
      final ref = await _firebaseAuth.createUserWithEmailAndPassword(email: _newUserController.email, password: _newUserController.password);
      completedAction = true;
      return ref.user!.uid;
    } on FirebaseAuthException catch (e) {
      log(e.toString(), error: FirebaseAuthException, time: DateTime.now(), name: e.runtimeType.toString());
      throw e.message.toString();
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

  static void deleteUser() async {
    await _firebaseAuth.currentUser!.delete();
    AuthProvider.completedAction = false;
  }

  static Future<void> logOut() async {
    await _firebaseAuth.signOut();
    UserController().dispose();
    TransactionController().dispose();
    AuthProvider.completedAction = false;
  }
}
