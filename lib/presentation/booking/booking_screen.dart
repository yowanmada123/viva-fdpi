import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../bloc/booking/booking_list/booking_bloc.dart';
import '../../bloc/fdpi/residence/residence_bloc.dart';
import '../../bloc/fdpi/site/site_bloc.dart';
import '../../data/repository/booking_repository.dart';
import '../../data/repository/fdpi_repository.dart';
import '../../models/booking.dart';
import '../widgets/BottomSheet/filter_booking.dart';
import 'booking_form_screen.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BookingView();
  }
}

class BookingView extends StatefulWidget {
  const BookingView({super.key});

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  final TextEditingController _searchController = TextEditingController();
  String? _currentSite;
  String? _currentCluster;
  String _currentStartDate = '';
  String _currentEndDate = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _updateFilters(
    String? cluster,
    String? city,
    String startDate,
    String endDate,
  ) {
    setState(() {
      _currentSite = cluster;
      _currentCluster = city;
      _currentStartDate = startDate;
      _currentEndDate = endDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => BookingBloc(
                bookingRepository: context.read<BookingRepository>(),
              )..add(GetBookings("", "", "", "")),
        ),
        BlocProvider(
          create:
              (context) =>
                  SiteBloc(fdpiRepository: context.read<FdpiRepository>())
                    ..add(GetSites("", "", "")),
        ),
        BlocProvider(
          create:
              (context) =>
                  ResidenceBloc(fdpiRepository: context.read<FdpiRepository>()),
        ),
      ],
      child: BookingViewBody(
        currentSite: _currentSite,
        currentCluster: _currentCluster,
        currentStartDate: _currentStartDate,
        currentEndDate: _currentEndDate,
        updateFilters: _updateFilters,
      ),
    );
  }
}

class BookingViewBody extends StatelessWidget {
  final String? currentSite;
  final String? currentCluster;
  final String? currentStartDate;
  final String? currentEndDate;
  final Function(
    String? cluster,
    String? city,
    String startDate,
    String endDate,
  )
  updateFilters;

  const BookingViewBody({
    super.key,
    required this.currentSite,
    required this.currentCluster,
    required this.currentStartDate,
    required this.currentEndDate,
    required this.updateFilters,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 245, 245, 245),
        title: const Text("Booking List"),
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 12.0, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: Clip.hardEdge,
            child: IconButton(
              icon: const Icon(Icons.filter_list),
              padding: const EdgeInsets.all(2.0),
              color: const Color(0xFF1C3FAA),
              onPressed: () {
                final bookingBloc = context.read<BookingBloc>();
                final residenceBloc = context.read<ResidenceBloc>();
                final siteBloc = context.read<SiteBloc>();

                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return BlocProvider.value(
                      value: bookingBloc,
                      child: FilterBottomSheet(
                        initialSite: currentSite,
                        initialCluster: currentCluster,
                        initialStartDate: currentStartDate ?? '',
                        initialEndDate: currentEndDate ?? '',
                        onApplyFilters: updateFilters,
                        residenceBloc: residenceBloc,
                        siteBloc: siteBloc,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: Container(
        color: Color.fromARGB(255, 245, 245, 245),
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Daftar Booking',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  FilledButton(
                    onPressed: () {
                      final bookingBloc = context.read<BookingBloc>();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  BookingFormScreen(bookingBloc: bookingBloc),
                        ),
                      );
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF1C3FAA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 2.w,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.add),
                        SizedBox(width: 8.w),
                        const Text("Add"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<BookingBloc, BookingState>(
                builder: (context, state) {
                  if (state is BookingLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is BookingLoaded) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: ListView.separated(
                        itemCount: state.bookings.length,
                        separatorBuilder:
                            (context, index) => SizedBox(height: 16.w),
                        itemBuilder:
                            (context, index) =>
                                BookingCard(booking: state.bookings[index]),
                      ),
                    );
                  } else if (state is BookingLoadFailure) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: Text("No data"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final Booking booking;
  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                booking.namaCustomer,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color:
                      booking.trType == "NEGO"
                          ? const Color.fromARGB(255, 74, 105, 242)
                          : const Color(0xffF2994A),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  booking.trType == "NEGO" ? "Negosiasi" : "Booking",
                  style: const TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            booking.telepon.isEmpty
                ? "Telpon tidak terdaftar"
                : booking.telepon,
          ),
          const SizedBox(height: 4),
          Text(booking.alamatCustomer),
          const SizedBox(height: 4),
          Text(booking.clusterName),
          const SizedBox(height: 4),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffEAF1FF),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Harga Asli', style: TextStyle(fontSize: 16)),
                    Text(
                      'Rp. ${NumberFormat.decimalPattern('de').format(booking.priceList)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Diskon', style: TextStyle(fontSize: 16)),
                    Text(
                      'Rp. ${NumberFormat.decimalPattern('de').format(booking.discount)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
