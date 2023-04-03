import 'package:firebase_auth_getx_localization/screens/second/second_screen.dart';
import 'package:firebase_auth_getx_localization/screens/third/third_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/Auth_controller.dart';
import '../../controller/profile_controller.dart';
import '../auth/components/mian_drawer.dart';
import '../profile/profile_edit.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthenticationServices authcontroller = Get.put(AuthenticationServices());
  ProfileController profile = Get.put(ProfileController());

  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    profile.getUserDetails();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Column(
          children: [
            const Text("hello "),
          ],
        ),
      ),
    );
  }
}
