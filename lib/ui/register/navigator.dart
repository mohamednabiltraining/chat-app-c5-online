import 'package:chat_c5/base.dart';
import 'package:chat_c5/model/my_user.dart';

abstract class RegisterNavigator extends BaseNavigator{
  void gotoHome(MyUser myUser);
}