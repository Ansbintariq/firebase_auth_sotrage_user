import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/Auth_controller.dart';
import '../../../controller/profile_controller.dart';
import '../../second/second_screen.dart';
import '../../third/third_screen.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({super.key});
  AuthenticationServices authcontroller = Get.put(AuthenticationServices());
  ProfileController profile = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 240,
      backgroundColor: Color.fromARGB(255, 123, 141, 231),
      child: DrawerHeader(
        child: Obx(
          () => Column(
            children: [
              SizedBox(height: 10),
              Center(
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 30,
                  backgroundImage: NetworkImage(profile.user.value.url == null
                      ? "https://cdn.pixabay.com/photo/2019/08/11/18/59/icon-4399701_1280.png"
                      : profile.user.value.url!.isEmpty
                          ? "https://cdn.pixabay.com/photo/2019/08/11/18/59/icon-4399701_1280.png"
                          : profile.user.value.url!),
                ),
              ),
              SizedBox(height: 10),
              Text(profile.user.value.name ?? "empty",
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              Text(profile.user.value.email ?? "empty",
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              const Divider(
                  thickness: .06, color: Color.fromARGB(255, 30, 29, 29)),
              ListTile(
                iconColor: Colors.white,
                leading: const Icon(Icons.person),
                title: const Text('My Profile',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Get.toNamed('/myProfile');
                },
              ),
              ListTile(
                iconColor: Colors.white,
                leading: const Icon(Icons.book),
                title:
                    const Text('Orders', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Get.to(() => SecondScreen());
                },
              ),
              ListTile(
                iconColor: Colors.white,
                leading: const Icon(Icons.subscriptions),
                title: const Text('Setting',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Get.to(() => ThirdScreen());
                },
              ),
              ListTile(
                iconColor: Colors.white,
                leading: const Icon(Icons.logout),
                title: const Text('Log Out',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  authcontroller.signOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
