import 'package:flutter/material.dart';
import 'package:pub_dev_packages/constants/colors.dart';

class Skeleton extends StatelessWidget {
  final double height;
  final double width;
  final double? borderRadius;
  const Skeleton({
    super.key,
    required this.height,
    required this.width,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
      ),
    );
  }
}
