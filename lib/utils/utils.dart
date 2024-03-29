import 'package:flutter/material.dart';
import 'package:login_register_app/res/constant/app_colors.dart';

class Utils {
  bool isValidEmail(String email) {
    RegExp regExp = RegExp(
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return regExp.hasMatch(email);
  }

  bool isValidPassword(String password) {
    RegExp regExp = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
    return regExp.hasMatch(password);
  }

  bool isValidName(String name) {
    RegExp regExp = RegExp(r"^[a-zA-Z]{3,}");
    return regExp.hasMatch(name);
  }

  ///Show SnackBar=================>
  void showSnackBar(
    BuildContext context, {
    //()require parameter {}optional parameter
    String? message,
    String? label,
    void Function()? onPressed,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message ?? ""),
      backgroundColor: AppColors.darkGray,
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(label: label ?? "", onPressed: onPressed ?? () {}),
    ));
  }
}
