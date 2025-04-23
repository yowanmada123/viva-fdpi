import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BookingView();
  }
}

class BookingView extends StatelessWidget {
  const BookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Booking")),
      body: const Center(child: Text('Booking')),
    );
  }
}

// class BookingSearchForm extends StatefulBuilder {
//   const BookingSearchForm({super.key});

//   @override
//   State<BookingSearchForm> createState() => _BookingSearchFormState();
// }

// class _BookingSearchFormState extends State<BookingSearchForm> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
