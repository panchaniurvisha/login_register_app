import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_register_app/res/commen/appText.dart';
import 'package:login_register_app/res/commen/app_elevated_button.dart';
import 'package:login_register_app/res/commen/app_textform_field.dart';
import 'package:login_register_app/res/commen/media_query.dart';
import 'package:login_register_app/res/constant/app_colors.dart';
import 'package:login_register_app/res/constant/app_string.dart';

import '../../res/constant/app_images.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Utils utils = Utils();
  bool isSecurePassword = true;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? userData;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: EdgeInsets.all(height(context) / 40),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const AppText(
                    text: AppString.welcomeBack,
                  ),
                  AppTextFormField(
                      controller: emailController,
                      labelText: AppString.labelEmail,
                      hintText: AppString.hintEmailName,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          utils.isValidEmail(emailController.text)
                              ? null
                              : AppString.errorEmailTitle),
                  AppTextFormField(
                      controller: passwordController,
                      labelText: AppString.labelPassword,
                      hintText: AppString.hintTextPassword,
                      obscureText: isSecurePassword,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      suffixIcon: IconButton(
                        icon: Icon(isSecurePassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            isSecurePassword = !isSecurePassword;
                          });
                        },
                      ),
                      validator: (value) =>
                          utils.isValidPassword(passwordController.text)
                              ? null
                              : AppString.errorPasswordTitle),
                  AppElevatedButton(
                    text: AppString.login,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        loginUser();
                        debugPrint("Home Screen---------->");
                      }
                    },
                  ),
                  AppText(
                      text: AppString.loginWith,
                      fontWeight: FontWeight.w100,
                      color: AppColors.darkGray,
                      size: height(context) / 50),
                  IconButton(
                    onPressed: () {
                      //signInWithGoogle();
                    },
                    icon: Image.asset(
                      AppImages.googleLogo,
                      height: height(context) / 20,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                          text: AppString.doNotHaveAccount,
                          fontWeight: FontWeight.w100,
                          size: height(context) / 50),
                      TextButton(
                        child: AppText(
                            text: AppString.registerNow,
                            color: AppColors.lightBlueColor,
                            fontWeight: FontWeight.bold,
                            size: height(context) / 50),
                        onPressed: () {
                          Navigator.pushNamed(context, RoutesName.signUpScreen);
                          //signup screen
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  ///Check Email in firebaseAuth--------------->>
  loginUser() async {
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((value) {
        debugPrint("value-------->${value.user}");
        if (value.user!.emailVerified) {
          debugPrint("User is login");
          userData = value.user;
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.homeScreen, (route) => false);
        } else {
          debugPrint("Please verify the email");
          utils.showSnackBar(
            context,
            message: "Please verify the email",
            label: "Resent",
            onPressed: () => value.user!.sendEmailVerification(),
          );
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      }
    }
  }
}
