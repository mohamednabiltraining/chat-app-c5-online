import 'package:chat_c5/base.dart';
import 'package:chat_c5/database/database_utils.dart';
import 'package:chat_c5/firebase_errors.dart';
import 'package:chat_c5/model/my_user.dart';
import 'package:chat_c5/ui/register/navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// provider
class RegisterViewModel extends BaseViewModel<RegisterNavigator> {
  // Logic- hold Data
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void register(String email, String password, String firstName,
      String lastName, String userName) async {
    String? message;
    try {
      navigator?.showLoading();
      var result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      // add user in databse
      var user = MyUser(
          id: result.user?.uid ?? "",
          fName: firstName,
          lName: lastName,
          userName: userName,
          email: email);
      var task =  await DataBaseUtils.createDBUser(user);
      navigator?.gotoHome(user);
      return;
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseErrors.weakPassword) {
        message = 'The password provided is too weak.';
      } else if (e.code == FirebaseErrors.email_in_use) {
        message = 'The account already exists for that email';
      } else {
        message = 'Wrong username or password';
      }
    } catch (e) {
      message = 'something went wrong';
    }
    navigator?.hideDialog();
    if (message != null) {
      navigator?.showMessage(message);
    }
  }
}
