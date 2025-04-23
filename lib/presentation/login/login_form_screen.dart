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
      child: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController shifController = TextEditingController();

  bool _obscurePassword = true;

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
                TextFormField(
                  controller: usernameController,
                  style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Username',
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(vertical: 0),
                      child: Icon(Icons.person, size: 16),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 12,
                    ),
                    isDense: true,
                    alignLabelWithHint: true,
                  ),
                ),
                SizedBox(height: 20.w),
                TextFormField(
                  controller: passwordController,
                  style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(vertical: 0),
                      child: Icon(Icons.lock, size: 16),
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.symmetric(vertical: 0),
                      child: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 16,
                        ),
                        onPressed:
                            () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        splashRadius: 14,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 12,
                    ),
                    isDense: true,
                    alignLabelWithHint: true,
                  ),
                  obscureText: _obscurePassword,
                ),
                SizedBox(height: 30.w),
                BlocConsumer<LoginFormBloc, LoginFormState>(
                  listener: (context, state) {
                    if (state is LoginFormError) {
                      usernameController.clear();
                      passwordController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Username atau Password salah"),
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Color(0xffEB5757),
                        ),
                      );
                    } else if (state is LoginFormSuccess) {
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

                          if (username.isEmpty || password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please fill in all fields.'),
                                duration: Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: Color(0xffEB5757),
                              ),
                            );
                            return;
                          }

                          context.read<LoginFormBloc>().add(
                            LoginFormSubmitted(
                              username: username,
                              password: password,
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
