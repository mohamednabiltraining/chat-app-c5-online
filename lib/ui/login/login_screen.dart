import 'package:chat_c5/base.dart';
import 'package:chat_c5/model/my_user.dart';
import 'package:chat_c5/provider/user_provider.dart';
import 'package:chat_c5/ui/home/home_screen.dart';
import 'package:chat_c5/ui/login/login_viewmodel.dart';
import 'package:chat_c5/ui/login/navigator.dart';
import 'package:chat_c5/ui/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'Login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen,LoginViewModel>
    implements LoginNavigator{
  @override
  LoginViewModel initViewModel() => LoginViewModel();
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }
  String email='';
  String password='';
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
      create: (buildContext)=>viewModel,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Image.asset(
              'assets/images/background_image.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(
                'Login',
              ),
            ),
            body: Container(
              padding: EdgeInsets.all(12),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                        decoration: InputDecoration(labelText: 'Email'),
                        onChanged: (text) {
                          email = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter Email';
                          }

                          bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(text);
                          if (!emailValid) {
                            return 'email format not valid';
                          }
                          return null;
                        }),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Password'),
                      onChanged: (text) {
                        password = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter password';
                        }
                        if (text.trim().length < 6) {
                          return 'password should be at least 6 chars';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                        onPressed: () {
                          validateForm();
                        },
                        child: Text('Login')),
                    InkWell(
                        onTap: (){
                          Navigator.pushReplacementNamed(context,
                              RegisterScreen.routeName);
                        },
                        child: Text("Don't have an account ? "))
                  ],
                ),
              ),
            ),
          )
        ],
      )
    );
  }
  void validateForm(){
    if(formKey.currentState?.validate()==true){
      viewModel.login(email,password);
    }
  }
  @override
  void gotoHome(MyUser user) {
    var userProvider = Provider.of<UserProvider>(context,listen: false);
    userProvider.user = user;

    Navigator.of(context).pushReplacementNamed( HomeScreen.routeName);
  }
}
