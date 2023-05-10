import 'package:firebase_auth_getx_localization/model/user_model.dart';
import 'package:firebase_auth_getx_localization/screens/chat_screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/images.dart';
import '../../controller/Auth_controller.dart';
import '../../controller/profile_controller.dart';
import 'widget/mian_drawer.dart';

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
          child: FutureBuilder<List<UserModel>>(
              future: authcontroller.getAllUsers(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    clipBehavior: Clip.none,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Card(
                              elevation: 8.0,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 6.0),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(()=>ChatScreen(),arguments: [snapshot.data![index].name,snapshot.data![index].url]);
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Color.fromRGBO(64, 75, 96, .9)),
                                  child: ListTile(
                                    leading: Container(
                                      padding: const EdgeInsets.only(right: 12.0),
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              right: BorderSide(
                                                  width: 1.0,
                                                  color: Colors.white24))),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: FadeInImage.assetNetwork(
                                          height: 60,
                                          width: 60,
                                          placeholder: Images.google,
                                          image: "${snapshot.data![index].url}",
                                          imageErrorBuilder: (c, o, s) =>
                                              Image.asset(
                                            Images.userImage,
                                            height: 60,
                                            width: 60,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    title: Text("${snapshot.data![index].name}",
                                        style:
                                            const TextStyle(color: Colors.white)),
                                    subtitle: Row(
                                      children: [
                                        const Icon(Icons.email_outlined,
                                            color: Color(0xffece6e6)),
                                        Text("${snapshot.data![index].email}",
                                            style: const TextStyle(color: Colors.white))
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      );
                    },
                  );
                } else {
                  return Column(
                    children: const [Text("null data")],
                  );
                }
              })),
    );
  }
}
