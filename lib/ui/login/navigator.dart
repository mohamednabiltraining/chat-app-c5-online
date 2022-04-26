import 'package:chat_c5/base.dart';
import 'package:chat_c5/model/my_user.dart';

abstract class LoginNavigator implements BaseNavigator{

  void gotoHome(MyUser user);
}