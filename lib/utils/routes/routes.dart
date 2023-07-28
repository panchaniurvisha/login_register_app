import 'package:flutter/cupertino.dart';
import 'package:login_register_app/utils/routes/routes_name.dart';

import '../../view/home/home_screen.dart';
import '../../view/login/login_screen.dart';
import '../../view/sign_up/SignUpScreen.dart';
import '../../view/splash/splash_screen.dart';

Map<String, WidgetBuilder> appRoutes = {
  RoutesName.splashScreen: (context) => const SplashScreen(),
  RoutesName.loginScreen: (context) => const LoginScreen(),
  RoutesName.homeScreen: (context) => const HomeScreen(),
  RoutesName.signUpScreen: (context) => const SignUpScreen(),
};
