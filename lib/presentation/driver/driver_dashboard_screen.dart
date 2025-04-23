import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/auth/authentication/authentication_bloc.dart';
import '../../bloc/auth/logout/logout_bloc.dart';
import '../../data/repository/auth_repository.dart';
import '../booking/booking_screen.dart';
import '../fdpi/fdpi_residences_screen.dart';
import '../widgets/logout_button.dart';

class DriverDashboardScreen extends StatelessWidget {
  const DriverDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = context.read<AuthRepository>();

    return BlocProvider(
      create: (context) => LogoutBloc(authRepository),
      child: MyGridLayout(),
    );
  }
}

class MyGridLayout extends StatelessWidget {
  final List<Map<String, dynamic>> buttons = [
    {
      'icon': Icons.map,
      'text': 'Siteplan',
      'description': 'Lihat dan interaksi dengan layout cluster',
      'route': FDPIResidencesScreen(),
    },
    {
      'icon': Icons.book,
      'text': 'Booking',
      'description': 'Pesan atau negosiasi transaksi',
      'route': BookingScreen(),
    },
  ];

  void _navigateToScreen(BuildContext context, Map<String, dynamic> button) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => button['route']),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFBFD9FF),
        title: Text(
          'Fasindo App',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1C3FAA),
            fontFamily: 'Poppins',
          ),
        ),
        actions: [const LogOutButton()],
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(color: Color(0xFFBFD9FF)),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.waving_hand_rounded,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 8),
                        BlocBuilder<AuthenticationBloc, AuthenticationState>(
                          builder: (context, authState) {
                            if (authState is Authenticated &&
                                authState.user.username.isNotEmpty) {
                              return Text(
                                'Hi, ${authState.user.username}',
                                style: TextStyle(
                                  fontSize: max(24.sp, 24.0),
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF2F80ED),
                                  fontFamily: 'Poppins',
                                ),
                              );
                            }
                            return Text(
                              'Hi, Guess',
                              style: TextStyle(
                                fontSize: max(24.sp, 24.0),
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF2F80ED),
                                fontFamily: 'Poppins',
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 32.h,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFEAF1FF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(157, 158, 158, 158),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0.w, 4.h), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Featured Menu',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: max(16.sp, 16.0),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Expanded(
                        child: ListView.separated(
                          itemCount: buttons.length,
                          separatorBuilder:
                              (context, index) => SizedBox(height: 16.h),
                          itemBuilder:
                              (context, index) =>
                                  _buildMenuCard(context, buttons[index]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, Map<String, dynamic> button) {
    return Container(
      child: GestureDetector(
        onTap: () => _navigateToScreen(context, button),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Color(0xFFEAF1FF),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: Icon(
                  button['icon'],
                  color: Color(0xFF2F80ED),
                  size: 48.w,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      button['text'],
                      style: TextStyle(
                        fontSize: max(16.sp, 16.0),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      button['description'],
                      style: TextStyle(
                        fontSize: max(14.sp, 14.0),
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
