import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../models/fdpi/house.dart';

class FDPIDetailUnitScreen extends StatelessWidget {
  final House selectedHouse;

  const FDPIDetailUnitScreen({super.key, required this.selectedHouse});

  @override
  Widget build(BuildContext context) {
    return PortraitOrientationWrapper(
      child: FDPIDetailUnitView(selectedHouse: selectedHouse),
    );
  }
}

class FDPIDetailUnitView extends StatelessWidget {
  final House selectedHouse;

  const FDPIDetailUnitView({super.key, required this.selectedHouse});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFBFD9FF),
        title: Text(
          "Detail Unit",
          style: TextStyle(
            color: Color(0xFF1C3FAA),
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF1C3FAA),
          weight: 3, // This makes back button white
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cluster Name:',
              style: TextStyle(
                fontSize: max(16.sp, 16.0),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.w),
            Text(
              selectedHouse.clusterName,
              style: TextStyle(fontSize: max(14.sp, 14.0)),
            ),
            SizedBox(height: 8.w),
            Text(
              'House Name:',
              style: TextStyle(
                fontSize: max(16.sp, 16.0),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.w),
            Text(
              selectedHouse.name,
              style: TextStyle(fontSize: max(14.sp, 14.0)),
            ),
            SizedBox(height: 8.w),
            Text(
              'Common Name:',
              style: TextStyle(
                fontSize: max(16.sp, 16.0),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.w),
            Text(
              selectedHouse.commonName,
              style: TextStyle(fontSize: max(14.sp, 14.0)),
            ),
            SizedBox(height: 8.w),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Luas Bangunan(m²):',
                        style: TextStyle(
                          fontSize: max(16.sp, 16.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.w),
                      Text(
                        selectedHouse.buildingArea,
                        style: TextStyle(fontSize: max(14.sp, 14.0)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Luas Tanah(m²):',
                        style: TextStyle(
                          fontSize: max(16.sp, 16.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.w),
                      Text(
                        selectedHouse.landArea,
                        style: TextStyle(fontSize: max(14.sp, 14.0)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.w),
            Text(
              'Status:',
              style: TextStyle(
                fontSize: max(16.sp, 16.0),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.w),
            Text(
              selectedHouse.statName,
              style: TextStyle(fontSize: max(14.sp, 14.0)),
            ),
            SizedBox(height: 8.w),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tanggal Pembangunan:',
                        style: TextStyle(
                          fontSize: max(16.sp, 16.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.w),
                      Text(
                        selectedHouse.dateBuild != null
                            ? DateFormat(
                              "dd MMM yyyy",
                            ).format(selectedHouse.dateBuild!)
                            : 'Not built yet',
                        style: TextStyle(fontSize: max(14.sp, 14.0)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tanggal Selesai:',
                        style: TextStyle(
                          fontSize: max(16.sp, 16.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.w),
                      Text(
                        selectedHouse.dateFinish != null
                            ? DateFormat(
                              "dd MMM yyyy",
                            ).format(selectedHouse.dateFinish!)
                            : 'Not finished yet',
                        style: TextStyle(fontSize: max(14.sp, 14.0)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.w),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Status Penjualan:',
                        style: TextStyle(
                          fontSize: max(16.sp, 16.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.w),
                      Text(
                        selectedHouse.soldStatName,
                        style: TextStyle(fontSize: max(14.sp, 14.0)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tanggal Penjualan:',
                        style: TextStyle(
                          fontSize: max(16.sp, 16.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.w),
                      Text(
                        selectedHouse.dateSold != null
                            ? DateFormat(
                              "dd MMM yyyy",
                            ).format(selectedHouse.dateSold!)
                            : 'Not sold yet',
                        style: TextStyle(fontSize: max(14.sp, 14.0)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.w),
            Text(
              'Deskripsi:',
              style: TextStyle(
                fontSize: max(16.sp, 16.0),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.w),
            Text(
              selectedHouse.description,
              style: TextStyle(fontSize: max(14.sp, 14.0)),
            ),
          ],
        ),
      ),
    );
  }
}

class PortraitOrientationWrapper extends StatefulWidget {
  final Widget child;

  const PortraitOrientationWrapper({super.key, required this.child});

  @override
  State<PortraitOrientationWrapper> createState() =>
      _PortraitOrientationWrapperState();
}

class _PortraitOrientationWrapperState
    extends State<PortraitOrientationWrapper> {
  @override
  void initState() {
    super.initState();
    // Set landscape when widget initializes
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    // Reset to portrait when widget disposes
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
