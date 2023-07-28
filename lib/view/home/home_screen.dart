import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_register_app/res/commen/appText.dart';
import 'package:login_register_app/res/commen/media_query.dart';
import 'package:login_register_app/res/constant/app_colors.dart';
import 'package:login_register_app/res/constant/app_string.dart';
import 'package:login_register_app/utils/routes/routes_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      backgroundColor: AppColors.lightBlueColor,
      title: AppText(text: AppString.titleOfAppBar, size: height(context) / 40),
      actions: [
        IconButton(
            onPressed: () {
              firebaseAuth.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, RoutesName.loginScreen, (route) => false);
            },
            icon: const Icon(Icons.logout))
      ],
    ));
  }
}
