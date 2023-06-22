import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import '../controllers/new_user_controller.dart';
import '../controllers/user_controller.dart';
import '../models/user.dart';

class UserDetailsProvider {
  UserDetailsProvider._();

  static final _userController = UserController();
  static final _newUserController = NewUserController();
  static final _firebaseDatabase = FirebaseDatabase.instance;

  static Future<void> createUser(String id) async {
    try {
      await _firebaseDatabase.ref(id).set(_newUserController.toMap());
      _userController.initialize(User.fromMap(id, _newUserController.toMap()));
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

  static Future<void> retrieveUserDetails(String id) async {
    try {
      final ref = await _firebaseDatabase.ref(id).get();
      _userController.initialize(User.fromMap(ref.key!, (ref.value! as Map)));
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
}
