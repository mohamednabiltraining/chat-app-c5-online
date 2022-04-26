import 'package:chat_c5/base.dart';
import 'package:chat_c5/model/my_user.dart';
import 'package:chat_c5/provider/user_provider.dart';
import 'package:chat_c5/ui/home/home_screen.dart';
import 'package:chat_c5/ui/login/login_screen.dart';
import 'package:chat_c5/ui/register/navigator.dart';
import 'package:chat_c5/ui/register/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseState<RegisterScreen,RegisterViewModel>
implements RegisterNavigator{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  String firstName = '';

  String lastName = '';

  String email = '';

  String password = '';

  String userName = '';

  @override
  void initState() {
    super.initState();
    // don't forget
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Builder(builder: (_) {
        return Stack(
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
                  'Create Account',
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
                        decoration: InputDecoration(labelText: 'First Name'),
                        onChanged: (text) {
                          firstName = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter first Name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                          decoration: InputDecoration(labelText: 'Last Name'),
                          onChanged: (text) {
                            lastName = text;
                          },
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please enter last Name';
                            }
                            return null;
                          }),
                      TextFormField(
                          decoration: InputDecoration(labelText: 'User Name'),
                          onChanged: (text) {
                            userName = text;
                          },
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please enter user Name';
                            }
                            if (text.contains(' ')) {
                              return 'user name must not contains white spaces';
                            }
                            return null;
                          }),
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
                          child: Text('Create Account')),
                      InkWell(
                          onTap: (){
                            Navigator.pushReplacementNamed(context,
                                LoginScreen.routeName);
                          },
                          child: Text("Already have an account ? "))
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  void validateForm() {
    if (formKey.currentState?.validate() == true) {
      // create Account
      viewModel.register(email, password,firstName,lastName,userName);
    }
  }

  @override
  RegisterViewModel initViewModel() {
    return RegisterViewModel();
  }

  @override
  void gotoHome(MyUser user) {
    hideDialog();
    var userProvider = Provider.of<UserProvider>(context,listen: false);
    userProvider.user = user;
    Navigator.of(context)
        .pushReplacementNamed(HomeScreen.routeName);
  }
}
