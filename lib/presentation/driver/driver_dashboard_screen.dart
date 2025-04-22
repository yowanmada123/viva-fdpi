import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/authentication/authentication_bloc.dart';
import '../../bloc/auth/logout/logout_bloc.dart';
import '../../data/repository/auth_repository.dart';
import '../booking/booking_screen.dart';
import '../fdpi/fdpi_residences_screen.dart';

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
        title: const Text(
          'FDPI',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1C3FAA),
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(color: Color(0xFFBFD9FF)),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
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
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF2F80ED),
                                  fontFamily: 'Poppins',
                                ),
                              );
                            }
                            return const Text(
                              'Hi, Guess',
                              style: TextStyle(
                                fontSize: 16,
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  decoration: const BoxDecoration(
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
                        offset: Offset(0, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Featured Menu',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 16),
                      Expanded(
                        child: ListView.separated(
                          itemCount: buttons.length,
                          separatorBuilder:
                              (context, index) => const SizedBox(height: 16),
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
          padding: const EdgeInsets.all(16),
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
                child: Icon(button['icon'], color: Color(0xFF2F80ED), size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      button['text'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      button['description'],
                      style: TextStyle(fontSize: 10, color: Colors.grey),
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
