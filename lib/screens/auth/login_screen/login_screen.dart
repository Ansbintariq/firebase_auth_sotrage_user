import 'package:firebase_auth_getx_localization/components/text_filed/custom_text_f.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/buttons/custom_button.dart';
import '../../../config/constant.dart';
import '../../../config/images.dart';
import '../../../controller/Auth_controller.dart';
import '../../../mock_data/mock_theme_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ThemeModel? themeModel;
  @override
  void initState() {
    themeModel=ThemeModel();
    super.initState();
  }
  final _formKey = GlobalKey<FormState>();

  AuthenticationServices controller = Get.put(AuthenticationServices());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * .12,
            ),
            const Icon(
              Icons.lock,
              size: 60,
              color: Color.fromARGB(255, 155, 155, 155),
            ),
            SizedBox(
              height: size.height * .03,
            ),
            const Text(Constants.welcome),
            SizedBox(
              height: size.height * .03,
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CustomTextField(
                      headerText: 'Email',
                      controller: controller.emailController,
                      hintText: "Enter Your email  ",
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                      focusNode: controller.emailFocus,
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
                      hintText: "Enter Your password ",
                      controller: controller.passwordController,
                      obscureText: true,
                      inputAction: TextInputAction.done,
                      // focusNode: controller.nameFocus,
                      validator: (value) {
                        if (value!.isEmpty) {
                          controller.nameFocus.requestFocus();
                          return 'Please Enter Your Password';
                        } else if (!RegExp(r'^[A-Za-z\d@$!%*?&]{8,}$')
                            .hasMatch(value)) {
                          controller.nameFocus.requestFocus();
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
                              color: Color.fromARGB(255, 208, 212, 212),
                            )
                          : CustomButton(
                              textcolor: const Color.fromARGB(255, 36, 36, 36),
                              bgcolor: const Color.fromARGB(255, 33, 187, 243),
                              text: 'Login',
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  controller.logIn(
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
                        Text(Constants.notHave + " "),
                        TextButton(
                            onPressed: () {
                              Get.offNamed('/reg');
                            },
                            child: Text(Constants.sign_up)),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * .03,
            ),
            Row(
              children: const [
                Expanded(
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                Text("Or Continue with"),
                Expanded(
                  child: Divider(
                    thickness: 1,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * .02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RawMaterialButton(
                  constraints: BoxConstraints.tight(const Size(50, 60)),
                  onPressed: () {
                    controller.googleLogIn();
                  },
                  shape: const CircleBorder(),
                  fillColor: const Color.fromARGB(255, 231, 228, 228),
                  elevation: 10,
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
                  constraints: BoxConstraints.tight(const Size(50, 70)),
                  onPressed: () {
                    Get.offNamed('/phonelogin');
                  },
                  shape: const CircleBorder(),
                  elevation: 10,
                  fillColor: const Color.fromARGB(255, 231, 228, 228),
                  child: const Icon(
                    Icons.phone,
                    size: 35,
                    color: Color.fromARGB(255, 80, 96, 238),
                  ),
                ),
                RawMaterialButton(
                  elevation: 10,
                  constraints: BoxConstraints.tight(const Size(50, 70)),
                  onPressed: () {
                    controller.signInWithFacebook();
                  },
                  shape: const CircleBorder(),
                  fillColor: const Color.fromARGB(255, 230, 229, 229),
                  child: const Icon(
                    Icons.facebook,
                    size: 35,
                    color: Color.fromARGB(255, 80, 96, 238),
                  ),
                ),
              ],
            ),
          GestureDetector(
            onTap:() {
              print(themeModel?.mockTheme['bg']);
            },
            child: Container(
              height: 40,
              width: 40,
               // color: Color(int.parse(themeModel!.mockTheme['app_bar'].toString())),
            //  int.parse(themeModel!.mockTheme['app_bar'].toString())
            ),
          )
          ],
        ),
      ),
    );
  }
}
