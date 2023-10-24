import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pub_dev_packages/constants/colors.dart';

class ScrollUpButton extends StatelessWidget {
  final void Function()? scrollToTop;
  const ScrollUpButton({super.key, required this.scrollToTop});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: scrollToTop,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondaryColor,
        shape: const CircleBorder(
            side: BorderSide(
          color: Colors.grey,
          width: 1,
        )),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Transform.rotate(
          angle: pi / 2,
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
