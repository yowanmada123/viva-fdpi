import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/fdpi/residence.dart';
import '../fdpi/fdpi_coordinates_screen.dart';

class ResidenceCard extends StatelessWidget {
  final Residence detailResidence;

  const ResidenceCard({super.key, required this.detailResidence});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => FDPICoordinatesScreen(
                    idCluster: detailResidence.idSite,
                    clusterImg: detailResidence.imgCluster,
                    clusterName: detailResidence.siteName,
                  ),
            ),
          ),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (detailResidence.imgClusterThumbnail.isNotEmpty) ...[
              AspectRatio(
                aspectRatio: 16 / 9, // Your desired ratio (width/height)
                child: Image(
                  image: CachedNetworkImageProvider(
                    'https://v2.kencana.org/storage/${detailResidence.imgClusterThumbnail}',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ],
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    detailResidence.siteName,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: max(16.sp, 16.0),
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SizedBox(height: 4.w),
                  if (detailResidence.siteAddress.isNotEmpty) ...[
                    Text(
                      detailResidence.siteAddress,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: max(12.sp, 12.0),
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                  Text(
                    detailResidence.remark,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: max(12.sp, 12),
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
