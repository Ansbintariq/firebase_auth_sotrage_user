import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth_getx_localization/controller/users_controller.dart';
import 'package:firebase_auth_getx_localization/model/user_model.dart';
import 'package:firebase_auth_getx_localization/screens/chat_screen/chat_screen.dart';
import 'package:firebase_auth_getx_localization/screens/chat_screen/model/chat_user_model.dart';
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
  UserController userController = Get.put(UserController());
  ProfileController profile = Get.put(ProfileController());
  List<ChatUser> list = [];
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
      body: StreamBuilder(
          stream: userController.firestore.collection("users").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data?.docs;
              list =
                  data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
              return ListView.builder(
                clipBehavior: Clip.none,
                shrinkWrap: true,
                primary: false,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  // if(snapshot.data![index].uid == userController.auth.currentUser!.uid){
                  //   return Container(height:0);
                  // }
                  return Column(
                    children: [
                      Card(
                          elevation: 8.0,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6.0),
                          child: GestureDetector(
                            onTap: () {
                               Get.to(()=>ChatScreen(user: list[index]),arguments: [list[index].name,list[index].image]);
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
                                    borderRadius: BorderRadius.circular(60),
                                    child: CachedNetworkImage(
                                      height: 60,
                                      width: 60,
                                      //   progressIndicatorBuilder: (context, url, downloadProgress) =>
                                      // CircularProgressIndicator(value: downloadProgress.progress),
                                      imageUrl: "${list[index].image}",
                                      errorWidget: (c, o, s) => Image.asset(
                                        Images.userImage,
                                        height: 60,
                                        width: 60,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                title: Text("${list[index].name}",
                                    style:
                                        const TextStyle(color: Colors.white)),
                                trailing: Icon(Icons.check_circle),
                                subtitle: Row(
                                  children: [
                                    const Icon(Icons.email_outlined,
                                        color: Color(0xffece6e6)),
                                    Expanded(
                                      child: Text("${list[index].email}",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              overflow: TextOverflow.ellipsis)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )),
                    ],
                  );
                },
              );
            } else {
              return Center(
                child: Column(
                  children: const [Text("Nothing Found...")],
                ),
              );
            }
          }),
    );
  }
}
