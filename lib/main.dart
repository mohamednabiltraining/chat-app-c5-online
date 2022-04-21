import 'package:chat_c5/ui/login/login_screen.dart';
import 'package:chat_c5/ui/register/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApplication());
}
class MyApplication extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        RegisterScreen.routeName:(_)=>RegisterScreen(),
        LoginScreen.routeName:(_)=>LoginScreen(),
      },
      initialRoute: LoginScreen.routeName,
      title: 'Chat-App',
    );
  }
}