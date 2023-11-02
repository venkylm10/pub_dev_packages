import 'package:flutter/material.dart';
import 'package:pub_dev_packages/utils/skeleton.dart';

class PackageHeaderTileShimmer extends StatelessWidget {
  const PackageHeaderTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Skeleton(height: 32, width: 32, borderRadius: 16),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Skeleton(height: 20, width: 200, borderRadius: 10),
                Row(
                  children: [
                    Skeleton(height: 30, width: 100, borderRadius: 15),
                    SizedBox(width: 10),
                    Skeleton(height: 30, width: 140, borderRadius: 15),
                  ],
                ),
                SizedBox(height: 10),
                Skeleton(height: 20, width: double.infinity, borderRadius: 10),
                Skeleton(height: 20, width: double.infinity, borderRadius: 10),
                Skeleton(height: 20, width: 200, borderRadius: 10),
                SizedBox(height: 10),
                Row(
                  children: [
                    Skeleton(height: 30, width: 60, borderRadius: 15),
                    SizedBox(width: 10),
                    Skeleton(height: 30, width: 60, borderRadius: 15),
                    SizedBox(width: 10),
                    Skeleton(height: 30, width: 60, borderRadius: 15),
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
