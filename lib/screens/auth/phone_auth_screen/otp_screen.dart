import 'package:firebase_auth_getx_localization/components/buttons/custom_button.dart';
import 'package:firebase_auth_getx_localization/controller/Auth_controller.dart';
import 'package:firebase_auth_getx_localization/screens/auth/components/otp_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/text_filed/custom_text_f.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});
  AuthenticationServices controller = Get.put(AuthenticationServices());
  // dynamic otpcode = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Phone Number Verification'),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OtpBox(
                controller: controller.fieldOne,
              ),
              OtpBox(
                controller: controller.fieldTwo,
              ),
              OtpBox(
                controller: controller.fieldThree,
              ),
              OtpBox(
                controller: controller.fieldFour,
              ),
              OtpBox(
                controller: controller.fieldFive,
              ),
              OtpBox(
                controller: controller.fieldSix,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: CustomButton(
              text: "Submit",
              onTap: () {
                var otp = controller.fieldOne.text +
                    controller.fieldTwo.text +
                    controller.fieldThree.text +
                    controller.fieldFour.text +
                    controller.fieldFive.text +
                    controller.fieldSix.text;
                controller.verifyOtp(otp);
                print(otp);
              },
              bgcolor: Color.fromARGB(255, 84, 153, 248),
            ),
          ),
        ],
      ),
    );
  }
}
