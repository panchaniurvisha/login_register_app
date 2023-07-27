import 'package:flutter/material.dart';
import 'package:login_register_app/res/commen/media_query.dart';

import '../constant/app_colors.dart';

class AppTextFormField extends StatelessWidget {
  final bool? obscureText;
  final Widget? suffixIcon;
  final String? labelText;
  final String? hintText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  const AppTextFormField(
      {super.key,
      this.obscureText,
      this.suffixIcon,
      this.labelText,
      this.hintText,
      this.textInputAction,
      this.keyboardType,
      this.validator,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      controller: controller,
      autofocus: false,
      keyboardType: keyboardType,
      textInputAction: textInputAction ?? TextInputAction.next,
      decoration: InputDecoration(
          suffixIcon: suffixIcon ?? const SizedBox(),
          hintText: hintText!,
          filled: true,
          contentPadding: EdgeInsets.symmetric(
              vertical: height(context) / 60, horizontal: width(context) / 28),
          fillColor: AppColors.white,
          labelText: labelText!,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.lightWhite),
            borderRadius: BorderRadius.circular(width(context) / 40),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width(context) / 40),
            borderSide: const BorderSide(color: AppColors.lightBlueColor),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.red,
            ),
            borderRadius: BorderRadius.circular(width(context) / 40),
          )),
      validator: validator,
    );
  }
}
