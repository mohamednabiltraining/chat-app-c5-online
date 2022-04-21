import 'package:chat_c5/base.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginViewModel extends BaseViewModel<BaseNavigator>{

  var firebaseAuth = FirebaseAuth.instance;
  void login(String email,String password)async{
    String? message=null;
    try {
      navigator?.showLoading(isDismissable: true);
      print('dialog shown');
      var result = await firebaseAuth.signInWithEmailAndPassword(email: email,
          password: password);
      // read user from Databse
      print('logged in');
      message = 'User Logged in successfully';
    } on FirebaseAuthException catch (e) {
      message = 'Wrong Email or password';
    } catch (e) {
      message = 'something went wrong';
    }
    navigator?.hideDialog();
    if(message!=null){
      navigator?.showMessage(message);
    }
  }
}