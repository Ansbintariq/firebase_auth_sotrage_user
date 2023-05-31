//  '/': (context) => const GetStarted(),
//
//       '/reg': (context) => const SignUpScreen(),
//       '/home': (context) => const HomeScreen(),

import 'package:firebase_auth_getx_localization/components/bottom_navigationBar/bottom_navigation.dart';
import 'package:firebase_auth_getx_localization/routes/routes_constants.dart';
import 'package:flutter/material.dart';

import '../Screens/auth/login_screen/login_screen.dart';

import '../Screens/auth/phone_auth_screen/phone_screen.dart';
import '../Screens/auth/signup_screen/sign_up.dart';
import '../Screens/get_started/get_strated.dart';
import '../Screens/home_screen/home_screen.dart';
import '../screens/auth/phone_auth_screen/otp_screen.dart';
import '../screens/profile/profile_screen.dart';

final Map<String, WidgetBuilder> routes = {
  RoutesConstants.login: (context) => const LoginScreen(),
  RoutesConstants.bottomnavigation: (context) => const Dashbord(),
  RoutesConstants.started: (context) => const GetStarted(),
  RoutesConstants.signup: (context) => const SignUpScreen(),
  RoutesConstants.phonelogin: (context) => PhoneLogin(),
  RoutesConstants.userOtp: (context) => OtpScreen(),
  RoutesConstants.myProfile: (context) => ProfileScreen(),
  RoutesConstants.chat: (context) => HomeScreen(),
};
