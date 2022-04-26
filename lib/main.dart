import 'package:chat_c5/provider/user_provider.dart';
import 'package:chat_c5/ui/add_room/add_room_screen.dart';
import 'package:chat_c5/ui/home/home_screen.dart';
import 'package:chat_c5/ui/login/login_screen.dart';
import 'package:chat_c5/ui/register/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_)=>UserProvider()),
      ],
      child: MyApplication()));
}
class MyApplication extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return MaterialApp(
      routes: {
        RegisterScreen.routeName:(_)=>RegisterScreen(),
        LoginScreen.routeName:(_)=>LoginScreen(),
        HomeScreen.routeName:(_)=>HomeScreen(),
        AddRoomScreen.routeName:(_)=>AddRoomScreen()
      },
      initialRoute:userProvider.firebaseUser ==null? LoginScreen.routeName:
      HomeScreen.routeName,
      title: 'Chat-App',
    );
  }
}