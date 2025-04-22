import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../models/fdpi/house.dart';

class FDPIDetailUnitScreen extends StatelessWidget {
  final House selectedHouse;

  const FDPIDetailUnitScreen({Key? key, required this.selectedHouse})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PortraitOrientationWrapper(
      child: FDPIDetailUnitView(selectedHouse: selectedHouse),
    );
  }
}

class FDPIDetailUnitView extends StatelessWidget {
  final House selectedHouse;

  const FDPIDetailUnitView({Key? key, required this.selectedHouse})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1E4694),
        title: Text("Detail Unit", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(
          color: Colors.white, // This makes back button white
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cluster Name:',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(selectedHouse.clusterName),
            SizedBox(height: 8),
            Text(
              'House Name:',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(selectedHouse.name),
            SizedBox(height: 8),
            Text(
              'Common Name:',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(selectedHouse.commonName),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Luas Bangunan(m²):',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(selectedHouse.buildingArea),
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
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(selectedHouse.landArea),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Status:',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(selectedHouse.statName),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tanggal Pembangunan:',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        selectedHouse.dateBuild != null
                            ? DateFormat(
                              "dd MMM yyyy",
                            ).format(selectedHouse.dateBuild!)
                            : 'Not sold yet',
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
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        selectedHouse.dateFinish != null
                            ? DateFormat(
                              "dd MMM yyyy",
                            ).format(selectedHouse.dateFinish!)
                            : 'Not sold yet',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Status Penjualan:',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(selectedHouse.soldStatName),
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
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        selectedHouse.dateSold != null
                            ? DateFormat(
                              "dd MMM yyyy",
                            ).format(selectedHouse.dateSold!)
                            : 'Not sold yet',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Deskripsi:',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(selectedHouse.description),
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
