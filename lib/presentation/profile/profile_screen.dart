import 'package:flutter/material.dart';

import '../widgets/bottom_navigator.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileView();
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 1),
      body: const Center(child: Text('Profile')),
    );
  }
}
