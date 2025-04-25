import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  Future<DateTime?> _selectDate(context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2021, 7, 25),
      firstDate: DateTime(2021),
      lastDate: DateTime(2022),
    );

    return pickedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
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
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 24.w),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: 'Cluster'),
            items:
                ['Cluster 1', 'Cluster 2'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
            onChanged: (value) {},
          ),
          SizedBox(height: 16.h),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: 'City'),
            items:
                ['City 1', 'City 2'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
            onChanged: (value) {},
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Start Date',
                    hintText: 'Select start date',
                    prefixIcon: Icon(Icons.calendar_today),
                    prefixIconColor: Color(0xff333333),
                  ),
                  readOnly: true,
                  onTap: () {
                    _selectDate(context);
                  },
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'End Date',
                    hintText: 'Select end date',
                    prefixIcon: Icon(Icons.calendar_today),
                    prefixIconColor: Color(0xff333333),
                  ),
                  readOnly: true,
                  onTap: () {
                    _selectDate(context);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    // Implement filter logic
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Color(0xFF1C3FAA),
                  ),
                  child: Text('Filter'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
