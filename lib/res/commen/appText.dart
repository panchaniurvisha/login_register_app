import 'package:flutter/material.dart';
import 'package:login_register_app/res/commen/media_query.dart';
import 'package:login_register_app/res/constant/app_colors.dart';

class AppText extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;
  const AppText({super.key, this.text, this.color, this.size, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
          fontSize: size ?? height(context) / 20,
          color: color ?? AppColors.lightBlack,
          fontWeight: fontWeight ?? FontWeight.w700),
    );
  }
}
