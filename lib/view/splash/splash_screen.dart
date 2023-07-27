import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:login_register_app/res/constant/app_images.dart';
import 'package:login_register_app/res/constant/app_string.dart';
import 'package:login_register_app/utils/routes/routes_name.dart';

import '../../res/commen/media_query.dart';
import '../../res/constant/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState

    Timer(Duration(seconds: 5), () {
      Navigator.pushNamedAndRemoveUntil(
          context, RoutesName.loginScreen, (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Image.asset(AppImages.plantImage),
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: height(context) / 3),
              Image.asset(AppImages.logoIcon, height: height(context) / 10),
              AnimatedTextKit(isRepeatingAnimation: true, animatedTexts: [
                WavyAnimatedText(
                  AppString.fruzz,
                  textStyle: TextStyle(
                    fontSize: height(context) / 20,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w900,
                    fontFamily: "Poppins",
                    color: AppColors.lightBlack,
                  ),
                ),
              ]),
              AnimatedTextKit(isRepeatingAnimation: true, animatedTexts: [
                TyperAnimatedText(
                  AppString.bottomText,
                  textStyle: TextStyle(
                    fontSize: height(context) / 40,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w900,
                    color: AppColors.lightBlueColor,
                  ),
                ),
              ]),
            ],
          ),
        )
      ],
    ));
  }
}
