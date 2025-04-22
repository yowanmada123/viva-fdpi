import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/auth/authentication/authentication_bloc.dart';
import '../../bloc/auth/login-form/login_form_bloc.dart';
import '../../data/repository/auth_repository.dart';

class LoginFormScreen extends StatelessWidget {
  const LoginFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = context.read<AuthRepository>();

    return BlocProvider(
      create: (context) => LoginFormBloc(authRepository),
      child: LoginFormView(),
    );
  }
}

class LoginFormView extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController shifController = TextEditingController();

  LoginFormView({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return KeyboardDismissOnTap(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                SizedBox(height: deviceSize.height * 0.05),
                Center(
                  child: Image.asset(
                    'assets/logo/logo-fdpi.png',
                    width: 200.w,
                    height: 200.w,
                  ),
                ),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    hintStyle: TextStyle(fontSize: 14),
                    isCollapsed: true,
                  ),
                ),
                SizedBox(height: 20.w),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(fontSize: 14),
                    isCollapsed: true,
                  ),
                  obscureText: true,
                ),
                // SizedBox(height: 20.w),
                // TextField(
                //   controller: shifController,
                //   decoration: InputDecoration(
                //     hintText: 'Shift',
                //     hintStyle: TextStyle(fontSize: 14),
                //     isCollapsed: true,
                //   ),
                // ),
                SizedBox(height: 30.w),
                BlocConsumer<LoginFormBloc, LoginFormState>(
                  listener: (context, state) {
                    if (state is LoginFormError) {
                      usernameController.clear();
                      passwordController.clear();
                      // shifController.clear();
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    } else if (state is LoginFormSuccess) {
                      print("masuk Sini login success");
                      BlocProvider.of<AuthenticationBloc>(context).add(
                        SetAuthenticationStatus(
                          isAuthenticated: true,
                          user: state.user,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        if (state is! LoginFormLoading) {
                          final username = usernameController.text;
                          final password = passwordController.text;
                          // final shif = shifController.text;
                          context.read<LoginFormBloc>().add(
                            LoginFormSubmitted(
                              username: username,
                              password: password,
                              // shif: "1",
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      child: Builder(
                        builder: (BuildContext context) {
                          if (state is LoginFormLoading) {
                            return CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            );
                          } else {
                            return Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
