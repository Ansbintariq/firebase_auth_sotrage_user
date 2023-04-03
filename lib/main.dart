import 'package:firebase_auth_getx_localization/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'Screens/auth/login_screen/login_screen.dart';
import 'Screens/auth/signup_screen/sign_up.dart';
import 'Screens/get_started/get_strated.dart';
import 'Screens/home_screen/home_screen.dart';
import 'components/helper/localization_service.dart';
import 'screens/auth/phone_auth_screen/otp_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: routes,
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ar', 'AR'),
        Locale('sk', 'SK'),
        Locale('ur', 'PK'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocales in supportedLocales) {
          if (supportedLocales.languageCode == locale!.languageCode &&
              supportedLocales.countryCode == locale.countryCode) {
            return supportedLocales;
          }
        }
        return supportedLocales.first;
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
