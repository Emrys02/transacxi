import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../controllers/new_user_controller.dart';
import '../controllers/user_controller.dart';
import '../models/user.dart';

class UserDetailsProvider {
  UserDetailsProvider._();

  static final _userController = UserController();
  static final _newUserController = NewUserController();
  static final _firebaseDatabase = FirebaseDatabase.instance;
  static final _firebaseStorage = FirebaseStorage.instance;

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

  static Future<void> uploadProfileImage(File image) async {
    try {
      final ref = await _firebaseStorage.ref(_userController.currentUser.id).putFile(image, SettableMetadata(contentType: "image"));
      _firebaseDatabase.ref(_userController.currentUser.id).update({"profileImage": await ref.ref.getDownloadURL()});
      _userController.currentUser.profileImage = await ref.ref.getDownloadURL();
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
