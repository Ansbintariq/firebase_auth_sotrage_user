import 'package:firebase_auth_getx_localization/components/buttons/custom_button.dart';
import 'package:firebase_auth_getx_localization/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../components/text_filed/custom_text_f.dart';
import '../../config/images.dart';
import '../../controller/Auth_controller.dart';
import '../../controller/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profile = Get.put(ProfileController());

  AuthenticationServices controller = Get.put(AuthenticationServices());

  @override
  void initState() {
    super.initState();
    controller.nameController.text = profile.user.value.name ?? "";
    controller.emailController.text = profile.user.value.email ?? "";
    controller.phoneController.text = profile.user.value.phone ?? "+92";
  }

  @override
  void dispose() {
    controller.emailController.clear();
    controller.nameController.clear();
    controller.phoneController.clear();
    controller.pickImage.value = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .4,
                      width: MediaQuery.of(context).size.width * 1,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: controller.pickImage.value != null
                                ? FileImage(controller.pickImage
                                        .value!) //this will update image on View screen from conroller
                                    as ImageProvider
                                : profile.user.value.url == null ||
                                        profile.user.value.url!.isEmpty
                                    ? AssetImage(Images.userImage)
                                        as ImageProvider
                                    : NetworkImage(profile.user.value
                                        .url!), //this will get image from firebase
                          ),
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40))),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * .30),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 169, 169, 168),
                                radius:
                                    MediaQuery.of(context).size.height * .08,
                                backgroundImage:
                                    controller.pickImage.value != null
                                        ? FileImage(controller.pickImage.value!)
                                            as ImageProvider
                                        : profile.user.value.url == null ||
                                                profile.user.value.url!.isEmpty
                                            ? AssetImage(Images.userImage)
                                                as ImageProvider
                                            : NetworkImage(
                                                profile.user.value.url!)),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: RawMaterialButton(
                                constraints: BoxConstraints.tight(Size(30, 30)),
                                onPressed: () {
                                  controller.getImageFromGallery();
                                },
                                child: Icon(Icons.camera_alt, size: 18),
                                shape: new CircleBorder(),
                                elevation: 0.0,
                                fillColor: Color.fromARGB(255, 196, 194, 194),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: controller.nameController,
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
                          enableEdit: false,
                          controller: controller.emailController,
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
                        controller: controller.phoneController,
                        hintText: 'Phone',
                        prefixIcon: Icons.phone,
                        inputType: TextInputType.number,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                      profile.loading.value
                          ? const CircularProgressIndicator(
                              color: Color.fromARGB(255, 218, 220, 220),
                            )
                          : CustomButton(
                              textcolor: const Color.fromARGB(255, 36, 36, 36),
                              bgcolor: const Color.fromARGB(255, 33, 187, 243),
                              text: "Update",
                              onTap: () async{
                                GetStorage().write("primary", "0xFFEDEDED");

                                final userData = UserModel(
                                  name: controller.nameController.text,
                                  email: controller.emailController.text,
                                  phone: controller.phoneController.text,
                                );
                                print(userData.name);
                                await profile.updateUser(userData);
                              },
                            )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
