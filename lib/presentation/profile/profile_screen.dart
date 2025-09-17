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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Fasindo App',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 1),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Authenticated) {
            final user = state.user;
            return Container(
              padding: EdgeInsets.fromLTRB(0, 32.w, 0, 0.w),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 64.w,
                    height: 64.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffE8F0FD),
                    ),
                    child: Icon(Icons.person, color: Colors.white, size: 56.w),
                  ),
                  const SizedBox(height: 16),
                  Text(user.name1, style: TextStyle(fontSize: 24)),
                  const SizedBox(height: 8),
                  Text(
                    '@${user.name1}',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 32),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 16.w,
                        horizontal: 24.w,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffE8F0FD),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: BlocConsumer<LogoutBloc, LogoutState>(
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
                            BlocProvider.of<AuthenticationBloc>(context).add(
                              SetAuthenticationStatus(isAuthenticated: false),
                            );
                            Navigator.of(
                              context,
                            ).popUntil((route) => route.isFirst);
                            return;
                          }
                        },
                        builder: (context, state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment:
                                MainAxisAlignment.start, // button tetap di atas
                            children: [
                              GestureDetector(
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
                                    vertical: 12.w,
                                    horizontal: 8.w,
                                  ),
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
                                      Icon(
                                        Icons.keyboard_arrow_right,
                                        size: 16.w,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
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
