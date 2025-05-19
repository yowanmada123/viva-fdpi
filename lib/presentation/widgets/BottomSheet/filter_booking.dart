import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../bloc/booking/booking_list/booking_bloc.dart';
import '../../../bloc/fdpi/residence/residence_bloc.dart';
import '../../../bloc/fdpi/site/site_bloc.dart';
import '../../../models/fdpi/residence.dart';
import '../../../models/fdpi/site.dart';

class FilterBottomSheet extends StatelessWidget {
  final String? initialSite;
  final String? initialCluster;
  final String initialStartDate;
  final String initialEndDate;
  final Function(String?, String?, String, String) onApplyFilters;
  final ResidenceBloc residenceBloc;
  final SiteBloc siteBloc;

  const FilterBottomSheet({
    super.key,
    required this.initialSite,
    required this.initialCluster,
    required this.initialStartDate,
    required this.initialEndDate,
    required this.onApplyFilters,
    required this.residenceBloc,
    required this.siteBloc,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: residenceBloc),
        BlocProvider.value(value: siteBloc),
      ],
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter Booking',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 24.w),
            _FilterForm(
              initialSite: initialSite,
              initialCluster: initialCluster,
              initialStartDate: initialStartDate,
              initialEndDate: initialEndDate,
              onApplyFilters: onApplyFilters,
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterForm extends StatefulWidget {
  final String? initialSite;
  final String? initialCluster;
  final String initialStartDate;
  final String initialEndDate;
  final Function(String?, String?, String, String) onApplyFilters;

  const _FilterForm({
    required this.initialSite,
    required this.initialCluster,
    required this.initialStartDate,
    required this.initialEndDate,
    required this.onApplyFilters,
  });

  @override
  State<_FilterForm> createState() => _FilterFormState();
}

class _FilterFormState extends State<_FilterForm> {
  late String? _site;
  late String? _cluster;
  late String _startDateText;
  late String _endDateText;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _site = widget.initialSite;
    _cluster = widget.initialCluster;
    _startDateText = widget.initialStartDate;
    _endDateText = widget.initialEndDate;
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = pickedDate;
          _startDateText = DateFormat('dd MMM yyyy').format(pickedDate);
        } else {
          _endDate = pickedDate;
          _endDateText = DateFormat('dd MMM yyyy').format(pickedDate);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<SiteBloc, SiteState>(
          builder: (context, state) {
            if (state is SiteLoadedSuccess) {
              return DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Site'),
                value: _site,
                items:
                    state.sites.map((Site item) {
                      return DropdownMenuItem<String>(
                        value: item.idSite,
                        child: Text(item.siteName),
                      );
                    }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _site = value;
                      _cluster = null;
                    });
                    context.read<ResidenceBloc>().add(
                      LoadResidence("", "", value, ""),
                    );
                  }
                },
              );
            }
            return DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Site'),
              value: _site,
              items: [],
              onChanged: (value) {},
            );
          },
        ),

        SizedBox(height: 16.h),
        BlocBuilder<ResidenceBloc, ResidenceState>(
          builder: (context, state) {
            if (state is ResidenceLoadSuccess) {
              return DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Cluster'),
                value: _cluster,
                items:
                    state.residences.map((Residence item) {
                      return DropdownMenuItem<String>(
                        value: item.idCluster,
                        child: Text(item.clusterName),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    _cluster = value;
                  });
                },
              );
            }
            return DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Cluster'),
              items: [],
              onChanged: (value) {},
            );
          },
        ),

        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Start Date',
                  hintText: 'Select start date',
                  prefixIcon: const Icon(Icons.calendar_today),
                  prefixIconColor: const Color(0xff333333),
                ),
                readOnly: true,
                onTap: () => _selectDate(context, true),
                controller: TextEditingController(text: _startDateText),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'End Date',
                  hintText: 'Select end date',
                  prefixIcon: const Icon(Icons.calendar_today),
                  prefixIconColor: const Color(0xff333333),
                ),
                readOnly: true,
                onTap: () => _selectDate(context, false),
                controller: TextEditingController(text: _endDateText),
              ),
            ),
          ],
        ),
        SizedBox(height: 24.h),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: FilledButton(
                onPressed: () {
                  final bookingBloc = context.read<BookingBloc>();
                  widget.onApplyFilters(
                    _site,
                    _cluster,
                    _startDateText,
                    _endDateText,
                  );
                  bookingBloc.add(
                    GetBookings(
                      _site ?? '',
                      _cluster ?? '',
                      _startDate != null
                          ? DateFormat(
                            'yyyy-MM-dd',
                          ).format(_startDate!).toString()
                          : '',
                      _endDate != null
                          ? DateFormat(
                            'yyyy-MM-dd',
                          ).format(_endDate!).toString()
                          : '',
                    ),
                  );
                  Navigator.pop(context);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF1C3FAA),
                ),
                child: const Text('Filter'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
