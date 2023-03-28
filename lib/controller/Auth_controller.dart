import 'dart:async';

import 'package:firebase_auth_getx_localization/model/user_model.dart';
import 'package:firebase_auth_getx_localization/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationServices extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  // 4 text editing controllers that associate with the 4 input otp fields
  final TextEditingController fieldOne = TextEditingController();
  final TextEditingController fieldTwo = TextEditingController();
  final TextEditingController fieldThree = TextEditingController();
  final TextEditingController fieldFour = TextEditingController();
  final TextEditingController fieldFive = TextEditingController();
  final TextEditingController fieldSix = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passFocus = FocusNode();
  static String? userName;
  static String? userEmail;
  static String? userId;
  static String? userUrl;
  static String? userPhone;
  RxBool loading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;
  RxString verifyId = ''.obs;
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    loading.value = true;
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(value.user!.uid)
            .set({
          'id': value.user!.uid,
          'name': name,
          'email': email,
        });
      }).then((value) => Timer(const Duration(seconds: 1), () {
                Get.toNamed('/login');
              }));
      nameController.clear();
      emailController.clear();
      passwordController.clear();
    } on FirebaseException catch (e) {
      Get.snackbar("Sign up Failed", "${e.message}",
          colorText: Colors.black,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255));
    }
    loading.value = false;
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    loading.value = true;
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential != null) {
        User? user = userCredential.user;
        Timer(const Duration(seconds: 1), () {
          Get.toNamed('/home');
          Get.snackbar("Login successful", "You are loged In");
        });
        emailController.clear();
        passwordController.clear();
      } else {}
    } on FirebaseException catch (e) {
      //  print("----------===${e}");

      Get.snackbar(
        "Login Failed",
        (e.message.toString()),
      );
    }
    loading.value = false;
  }

  Future googleLogIn() async {
    User? user;
    final GoogleSignInAccount? googleSignInAccount =
        await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;
    if (googleSignInAuthentication?.accessToken != null &&
        googleSignInAuthentication?.idToken != null) {
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );
      final UserCredential userCredential =
          await auth.signInWithCredential(authCredential);
      user = userCredential.user;
      Get.snackbar("Login successful", "You are loged In");
      //it will send data to firesotre
      userName = user?.displayName;
      userEmail = user?.email;
      userId = user?.uid;
      userUrl = user?.photoURL;
      userPhone = user?.phoneNumber;

      Get.toNamed('/home');
      googleUserData(user);
    }
    return user;
  }

  googleUserData(user) async {
    FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
      'name': userName,
      'email': userEmail,
      'uid': userId,
      'Url': userUrl,
      'phone': userPhone
    });
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
      Get.offNamed('/login');
      Get.snackbar("LogOut successful", "You are LogOut");
    } on FirebaseAuthException catch (e) {
      // print(e); // Displaying the error message
    }
  }

  Future phoneOTP(String number) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '$number',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        Get.snackbar(
          "OTP Faild ",
          ("OTP  not sent try again"),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        verifyId.value = verificationId;
        Get.snackbar(
          "OTP Send ",
          ("OTP sent successfully "),
        );
        phoneController.clear();
        Get.off('/userOtp');
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future verifyOtp(String otp) async {
    try {
      var credential = await auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: verifyId.value, smsCode: otp));
      Get.snackbar(
        "Login successful",
        ("welcome to our app"),
      );
      Get.off("/home");
      fieldOne.clear();
      fieldTwo.clear();
      fieldThree.clear();
      fieldFour.clear();
      fieldFive.clear();
      fieldSix.clear();
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "OTP Failed",
        (e.message.toString()),
      );
    }
  }
}
