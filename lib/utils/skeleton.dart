import 'package:flutter/material.dart';
import 'package:pub_dev_packages/constants/colors.dart';

class Skeleton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;
  final Widget? child;
  const Skeleton({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
    this.child,
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
      child: child,
    );
  }
}
