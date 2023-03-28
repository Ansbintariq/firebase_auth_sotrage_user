import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth_getx_localization/components/text_filed/custom_text_f.dart';
import 'package:firebase_auth_getx_localization/screens/auth/phone_auth_screen/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/buttons/custom_button.dart';
import '../../../config/constant.dart';
import '../../../config/images.dart';
import '../../../controller/Auth_controller.dart';
import '../components/login_form.dart';

class PhoneLogin extends StatelessWidget {
  PhoneLogin({super.key});

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
            // Padding(
            //   padding: const EdgeInsets.all(20.0),
            //   child: Container(
            //     alignment: Alignment.center,
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //         border: Border.all(),
            //         borderRadius: BorderRadius.circular(10)),
            //     child: Form(
            //       key: _formKey,
            //       child: Row(
            //         children: [
            //           SizedBox(
            //             child: CountryCodePicker(
            //               initialSelection: "PK",
            //               showCountryOnly: false,
            //               onChanged: (value) {
            //                 print(value);
            //               },
            //             ),
            //           ),
            //           SizedBox(
            //             height: 100,
            //             width: 300,
            //             child: TextFormField(
            //               decoration: const InputDecoration(
            //                 focusedBorder: InputBorder.none,
            //                 errorBorder: InputBorder.none,
            //                 focusedErrorBorder: InputBorder.none,
            //                 hintText: "enter phone number",
            //               ),
            //               controller: controller.phoneController,
            //               validator: (value) {
            //                 if (value!.isEmpty) {
            //                   controller.emailFocus.requestFocus();
            //                   return 'Please Enter Your Number';
            //                 } else if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
            //                     .hasMatch(value)) {
            //                   controller.emailFocus.requestFocus();
            //                   return 'Enter valid  Number';
            //                 } else {
            //                   return null;
            //                 }
            //               },
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CustomTextField(
                      prefixTap: () {},
                      // headerText: 'Phone',
                      controller: controller.phoneController,
                      hintText: "Enter Your Number  ",
                      inputType: TextInputType.phone,
                      inputAction: TextInputAction.done,
                      validator: (value) {
                        if (value!.isEmpty) {
                          controller.emailFocus.requestFocus();
                          return 'Please Enter Your Number';
                        } else if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                            .hasMatch(value)) {
                          controller.emailFocus.requestFocus();
                          return 'Enter valid  Number';
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
                              text: 'OTP',
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  final phoneNumber =
                                      controller.phoneController.text.trim();
                                  controller.phoneOTP(phoneNumber);
                                  print(phoneNumber);
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
                    Get.offNamed('/userOtp');
                  },
                  shape: const CircleBorder(),
                  elevation: 10,
                  fillColor: const Color.fromARGB(255, 231, 228, 228),
                  child: const Icon(
                    Icons.facebook,
                    size: 40,
                    color: Color.fromARGB(255, 80, 96, 238),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
