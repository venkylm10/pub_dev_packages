import 'package:flutter/material.dart';
import 'package:pub_dev_packages/constants/colors.dart';
import 'package:pub_dev_packages/constants/styles.dart';
import 'package:pub_dev_packages/globals/endpoints.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FavoritesInfo extends StatelessWidget {
  const FavoritesInfo({super.key});

  void knowMore() async {
    print("know more");
    const url = EndPoints.favoritesPageUrl;
    try {
      await launchUrlString(url);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.backgroundColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 4,
                    width: 35,
                    decoration: BoxDecoration(
                      color: AppColors.blue1,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
              Text(
                "Flutter Favorite program",
                style: AppStyles.subHeadingStyle,
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "The aim of the ",
                      style: AppStyles.normalTextStyle,
                    ),
                    TextSpan(
                      text: "Flutter Favorite Program",
                      style: AppStyles.normalTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                          " is to identify packages and plugins that you should first consider when building your app. This is not a guarantee of quality or suitability to your particular situation—you should always perform your own evaluation of packages and plugins for your project.",
                      style: AppStyles.normalTextStyle,
                    )
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, right: 20),
            child: GestureDetector(
              onTap: () => knowMore(),
              child: Text(
                "Know more",
                style: AppStyles.normalTextStyle.copyWith(
                  color: AppColors.blue1,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
