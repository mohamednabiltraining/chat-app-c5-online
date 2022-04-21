import 'package:chat_c5/base.dart';
import 'package:chat_c5/firebase_errors.dart';
import 'package:firebase_auth/firebase_auth.dart';

// provider
class RegisterViewModel extends BaseViewModel<BaseNavigator>{
  // Logic- hold Data
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void register(String email,String password)async{
    String? message;
    try {
      navigator?.showLoading();
      var result = await firebaseAuth.createUserWithEmailAndPassword(email: email,
          password: password);
      // add user in databse
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseErrors.weakPassword) {
        message = 'The password provided is too weak.';
      } else if (e.code == FirebaseErrors.email_in_use) {
        message = 'The account already exists for that email';
      }else {
        message = 'Wrong username or password';
      }
    } catch (e) {
      message = 'something went wrong';
    }
    navigator?.hideDialog();
    if(message!=null){
      navigator?.showMessage(message);
    }
  }
}