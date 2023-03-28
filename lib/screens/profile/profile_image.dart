import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/text_filed/custom_text_f.dart';
import '../../controller/Auth_controller.dart';

import '../../controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  ProfileController profile = Get.put(ProfileController());

  AuthenticationServices controller = Get.put(AuthenticationServices());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Obx(
            () => Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .4,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            profile.user.value.url ??
                                "https://cdn.pixabay.com/photo/2019/08/11/18/59/icon-4399701_1280.png",
                          )),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40))),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .33),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                              profile.user.value.url ??
                                  "https://cdn.pixabay.com/photo/2019/08/11/18/59/icon-4399701_1280.png",
                            )),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: MediaQuery.of(context).size.height * .048,
                            width: MediaQuery.of(context).size.width * .105,
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                borderRadius: BorderRadius.circular(60)),
                            child: IconButton(
                              onPressed: () {
                                controller.getImageFromGallery();
                              },
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CustomTextField(
                  hintText: 'Name',
                  prefixIcon: Icons.person,
                  inputType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      controller.nameFocus.requestFocus();
                      return 'Please Enter Your Name';
                    } else if (!RegExp('[a-zA-Z]').hasMatch(value)) {
                      controller.nameFocus.requestFocus();
                      return 'Enter valid  Email';
                    } else {
                      return null;
                    }
                  },
                ),
                CustomTextField(
                    hintText: 'Email',
                    prefixIcon: Icons.email,
                    inputType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        controller.emailFocus.requestFocus();
                        return 'Please Enter Your Email';
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        controller.emailFocus.requestFocus();
                        return 'Enter valid  Email';
                      } else {
                        return null;
                      }
                    }),
                CustomTextField(
                  hintText: 'Phone',
                  prefixIcon: Icons.phone,
                  inputType: TextInputType.number,
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
