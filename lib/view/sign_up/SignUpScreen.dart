import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_register_app/utils/utils.dart';

import '../../res/commen/appText.dart';
import '../../res/commen/app_elevated_button.dart';
import '../../res/commen/app_textform_field.dart';
import '../../res/commen/media_query.dart';
import '../../res/constant/app_colors.dart';
import '../../res/constant/app_images.dart';
import '../../res/constant/app_string.dart';
import '../../utils/routes/routes_name.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  bool isSecurePassword = true;
  bool value = false;
  Utils utils = Utils();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.all(height(context) / 40),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Align(alignment: Alignment.topLeft, child: BackButton()),
                const AppText(
                  text: AppString.registerTitle,
                ),
                AppTextFormField(
                  controller: firstNameController,
                  validator: (value) =>
                      utils.isValidName(firstNameController.text)
                          ? null
                          : AppString.errorTitle,
                  labelText: AppString.labelFullName,
                  hintText: AppString.hintTextName,
                  keyboardType: TextInputType.name,
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
                    obscureText: isSecurePassword,
                    hintText: AppString.hintTextPassword,
                    keyboardType: TextInputType.visiblePassword,
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
                AppTextFormField(
                  controller: confirmPasswordController,
                  keyboardType: TextInputType.text,
                  hintText: AppString.confirmPassword,
                  obscureText: isSecurePassword,
                  labelText: AppString.labelPassword,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppString.emptyConfirmPassword;
                    }
                    if (passwordController.text !=
                        confirmPasswordController.text) {
                      return AppString.errorConfirmPassword;
                    }
                    return null;
                  },
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
                ),
                AppElevatedButton(
                  text: AppString.register,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      createUserInAuth();
                      debugPrint("Login Screen---------->");
                      // Navigator.pushNamedAndRemoveUntil(
                      //     context, RoutesName.loginScreen, (route) => false);
                    }
                  },
                ),
                AppText(
                    text: AppString.registerWith,
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
                        text: AppString.haveAccount,
                        fontWeight: FontWeight.w100,
                        size: height(context) / 50),
                    TextButton(
                      child: AppText(
                          text: AppString.loginNow,
                          color: AppColors.lightBlueColor,
                          fontWeight: FontWeight.bold,
                          size: height(context) / 50),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, RoutesName.loginScreen, (route) => false);
                        //signup screen
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  createUserInAuth() async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((value) {
        debugPrint("Value----->${value.user}"); //user is used for access value
        user = value.user;
        user!.sendEmailVerification();
        Navigator.pushNamedAndRemoveUntil(
            context, RoutesName.loginScreen, (route) => false);
        //  createUserData();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
        utils.showSnackBar(context,
            message: "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
        utils.showSnackBar(context,
            message: "The account already exists for that email.");
      }
    } catch (e) {
      debugPrint("Error----$e");
    }
  }
}
