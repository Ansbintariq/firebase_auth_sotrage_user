import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/buttons/custom_button.dart';
import '../../../components/text_filed/custom_text_f.dart';
import '../../../config/constant.dart';
import '../../../config/images.dart';
import '../../../controller/Auth_controller.dart';
import '../../../controller/image_picker_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  AuthenticationServices controller = Get.put(AuthenticationServices());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              GetBuilder<AuthenticationServices>(
                builder: (logic) {
                  return Container(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          backgroundColor: Color.fromARGB(0, 136, 135, 135),
                          radius: 60,
                          backgroundImage: logic.pickImage.value != null
                              ? FileImage(logic.pickImage.value!)
                                  as ImageProvider
                              : ExactAssetImage(Images.userImage),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                borderRadius: BorderRadius.circular(100)),
                            child: IconButton(
                              onPressed: () {
                                controller.getImageFromGallery();
                              },
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Color.fromARGB(255, 255, 255, 255),
                                size: 16,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),
              const Text(Constants.welcome),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CustomTextField(
                        headerText: 'Name',
                        controller: controller.nameController,
                        hintText: "Enter Your Name  ",
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.next,
                        focusNode: controller.nameFocus,
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
                        headerText: 'Email',
                        controller: controller.emailController,
                        hintText: "Enter Your Email  ",
                        inputType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next,
                        //    focusNode: controller.emailFocus,
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
                        },
                      ),
                      CustomTextField(
                        headerText: 'Password',
                        hintText: "Enter Your Password ",
                        controller: controller.passwordController,
                        obscureText: true,
                        inputAction: TextInputAction.done,
                        //    focusNode: controller.passFocus,
                        validator: (value) {
                          if (value!.isEmpty) {
                            controller.passFocus.requestFocus();
                            return 'Please Enter Your Password';
                          } else if (!RegExp(r'^[A-Za-z\d@$!%*?&]{8,}$')
                              .hasMatch(value)) {
                            controller.passFocus.requestFocus();
                            return 'Enter valid Password';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: size.height * .02,
                      ),
                      Obx(
                        () => controller.loading.value
                            ? const CircularProgressIndicator(
                                color: Color.fromARGB(255, 218, 220, 220),
                              )
                            : CustomButton(
                                textcolor:
                                    const Color.fromARGB(255, 36, 36, 36),
                                bgcolor:
                                    const Color.fromARGB(255, 33, 187, 243),
                                text: 'Sign Up',
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    controller.signUp(
                                      name: controller.nameController.text,
                                      email: controller.emailController.text,
                                      password:
                                          controller.passwordController.text,
                                    );
                                  }
                                },
                              ),
                      ),
                      SizedBox(
                        height: size.height * .02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(Constants.already + " "),
                          TextButton(
                              onPressed: () {
                                Get.offNamed('/login');
                              },
                              child: Text(Constants.login))
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .08,
                  ),
                  const Expanded(
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                  const Text("Or Continue with"),
                  const Expanded(
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RawMaterialButton(
                    elevation: 10,
                    constraints: BoxConstraints.tight(const Size(50, 60)),
                    onPressed: () {
                      controller.googleLogIn();
                    },
                    shape: const CircleBorder(),
                    fillColor: const Color.fromARGB(255, 231, 228, 228),
                    child: const SizedBox(
                      height: 30,
                      width: 30,
                      child: Image(
                        image: AssetImage(
                          Images.google,
                        ),
                      ),
                    ),
                  ),
                  RawMaterialButton(
                    elevation: 10,
                    constraints: BoxConstraints.tight(const Size(50, 70)),
                    onPressed: () {},
                    shape: const CircleBorder(),
                    fillColor: const Color.fromARGB(255, 230, 229, 229),
                    child: const Icon(
                      Icons.facebook,
                      size: 40,
                      color: Color.fromARGB(255, 80, 96, 238),
                    ),
                  ),
                ],
              ),

              // Column(
              //   children: [CircularProgressIndicator()],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
