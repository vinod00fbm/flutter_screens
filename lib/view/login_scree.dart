import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/res/components/round_button.dart';
import 'package:flutter_mvvm/utils/utils.dart';
import 'package:flutter_mvvm/view_model/auth_viewmodel.dart';
import 'package:provider/provider.dart';

import '../res/colors/app_colors.dart';
import '../utils/routes/routes_names.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100.0),
          child: const Text(
            'Login',
            style: TextStyle(
              fontFamily: 'sourcesanspro_bold',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100.0),
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                focusNode: _emailFocusNode,
                onFieldSubmitted: (value) {
                  Utils.fieldFocusChange(
                      context, _emailFocusNode, _passwordFocusNode);
                },
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: AppColors.borderColor)),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: AppColors.borderColor)),
                    hintText: "Email",
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.alternate_email)),
              ),
            ),
            ValueListenableBuilder(
                valueListenable: _obsecurePassword,
                builder: (context, value, child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100.0),
                    child: TextFormField(
                      focusNode: _passwordFocusNode,
                      controller: _passwordController,
                      obscureText: _obsecurePassword.value,
                      obscuringCharacter: '*',
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: AppColors.borderColor)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: AppColors.borderColor)),
                          hintText: "Password",
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.password)),
                    ),
                  );
                }),
            SizedBox(
              height: height * .1,
            ),
            RoundedButton(
              title: 'Log In',
              loading: false,
              onPress: () {
                print('Log in pressed');
                if (_emailController.text.isEmpty) {
                  Utils.showFlushBarErrorMessage('Please enter email', context);
                } else if (_passwordController.text.isEmpty) {
                  Utils.showFlushBarErrorMessage(
                      'Please enter password', context);
                } else {
                  Map data = {
                    'email': _emailController.text.toString(),
                    'password': _passwordController.text.toString()
                  };
                  // uncomment to login
                  //authViewModel.loginApi(data,context);
                  Utils.showFlushBarSuccessMessage(
                      'User Created Successfully!', context);
                  Navigator.pushNamed(context, RoutesNames.createJob);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
