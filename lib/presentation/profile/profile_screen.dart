import 'package:fdpi_app/data/repository/auth_repository.dart';
import 'package:fdpi_app/models/errors/custom_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/auth/logout/logout_bloc.dart';
import '../widgets/base_pop_up.dart';
import '../widgets/bottom_navigator.dart';
import '../../bloc/auth/authentication/authentication_bloc.dart'; // Import the authentication bloc

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogoutBloc(context.read<AuthRepository>()),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 1),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Authenticated) {
            final user = state.user;
            return Container(
              padding: EdgeInsets.all(16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        Image.asset("assets/images/avatar.png").image,
                  ),
                  const SizedBox(height: 16),
                  Text(user.username, style: TextStyle(fontSize: 24)),
                  const SizedBox(height: 8),
                  Text(
                    '@${user.username}',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 32),
                  BlocConsumer<LogoutBloc, LogoutState>(
                    listener: (context, state) {
                      if (state is LogoutFailure) {
                        if (state.exception is UnauthorizedException) {
                          BlocProvider.of<AuthenticationBloc>(context).add(
                            SetAuthenticationStatus(
                              isAuthenticated: false,
                              user: null,
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Session Anda telah habis. Silakan login kembali",
                              ),
                              duration: Duration(seconds: 5),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Color(0xffEB5757),
                            ),
                          );
                          Navigator.of(
                            context,
                          ).popUntil((route) => route.isFirst);
                          return;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Logout Not Success")),
                        );
                      } else if (state is LogoutSuccess) {
                        BlocProvider.of<AuthenticationBloc>(
                          context,
                        ).add(SetAuthenticationStatus(isAuthenticated: false));
                        Navigator.of(
                          context,
                        ).popUntil((route) => route.isFirst);
                        return;
                      }
                    },
                    builder:
                        (context, state) => GestureDetector(
                          onTap: () {
                            showDialog<bool>(
                              context: context,
                              builder: (BuildContext childContext) {
                                return BasePopUpDialog(
                                  noText: "Tidak",
                                  yesText: "Ya",
                                  onNoPressed: () {},
                                  onYesPressed: () {
                                    if (state is! LogoutLoading) {
                                      context.read<LogoutBloc>().add(
                                        LogoutPressed(),
                                      );
                                    }
                                  },
                                  question:
                                      "Apakah Anda yakin ingin keluar dari aplikasi?",
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 16.w,
                              horizontal: 8.w,
                            ), // padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.logout),
                                SizedBox(width: 16.w),
                                Expanded(child: Text("Logout")),
                              ],
                            ),
                          ),
                        ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
