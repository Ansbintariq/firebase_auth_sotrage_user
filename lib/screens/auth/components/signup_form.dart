import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/constant.dart';
import '../../../controller/Auth_controller.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({super.key});
  AuthenticationServices controller = Get.put(AuthenticationServices());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Card(
        margin: const EdgeInsets.all(5),
        elevation: 10,
        shadowColor: const Color.fromARGB(255, 166, 210, 245),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextFormField(
                controller: controller.nameController,
                decoration: const InputDecoration(
                  hintText: Constants.enter_name,
                  border: OutlineInputBorder(),
                ),
              ),
              TextFormField(
                controller: controller.emailController,
                decoration: const InputDecoration(
                  hintText: Constants.enter_email,
                  border: OutlineInputBorder(),
                ),
              ),
              TextFormField(
                obscureText: true,
                controller: controller.passwordController,
                decoration: const InputDecoration(
                  hintText: Constants.enter_password,
                  border: OutlineInputBorder(),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 88, 185, 238),
                    borderRadius: BorderRadius.circular(5)),
                width: MediaQuery.of(context).size.height * .38,
                child: TextButton(
                    onPressed: () {
                      controller.signUp(
                        name: controller.nameController.text,
                        email: controller.emailController.text,
                        password: controller.passwordController.text,
                      );
                    },
                    child: Obx(
                      () => controller.loading.value
                          ? const CircularProgressIndicator(
                              color: Color.fromARGB(255, 255, 255, 255),
                            )
                          : const Text(
                              Constants.sign_up,
                              style: TextStyle(color: Colors.white),
                            ),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an acount ?"),
                  TextButton(
                      onPressed: () {
                        Get.toNamed("/login");
                      },
                      child: const Text("Login")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
