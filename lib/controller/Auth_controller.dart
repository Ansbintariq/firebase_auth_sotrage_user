import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

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
  RxString imagePath = ''.obs;
  final pickImage = Rxn<File>();
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
  var url = ''.obs;
  //facebook user data variable

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
          .then((value) async {
        if (pickImage.value != null) {
          await uploadImageToFirebase();
        }

        //     print("hellooooooooo ${url.value}");
        FirebaseFirestore.instance
            .collection("users")
            .doc(value.user!.uid)
            .set({
          'id': value.user!.uid,
          'name': name,
          'email': email,
          'Url': url.value
        });
      }).then((value) => Timer(const Duration(seconds: 1), () {
                Get.snackbar("Sign Up successful", "You are Sign Up");
                Get.offNamed('/login');
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

  Future getImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      pickImage.value = File(image.path);
      update();
    } else {
      //  print("no image selected");
    }
  }

  Future uploadImageToFirebase() async {
    String imgId = DateTime.now().microsecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child('images$imgId');
    var tst = await reference.putFile(pickImage.value!);
    //  print("valueeeeeeeeeeeeeee===== ${tst}");
    url.value = await reference.getDownloadURL();
    // print("url===== ${url.value}");
    update();
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
          Get.offNamed('/home');
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

      Get.offNamed('/home');
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
        Get.offNamed('/userOtp');
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
      Get.offNamed("/home");
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

  Future signInWithFacebook() async {
    var userData;
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance
        .login(permissions: ['email', 'public_profile']);
    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    // Once signed in, return the UserCredential
    //use await  because it will take time to fetch access token if you not use 1st login and second time expection
    var accessToken = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);

    print("accessToken    --==============>$facebookAuthCredential");

    if (accessToken != null) {
      userData = await FacebookAuth.instance.getUserData();

      //  var uid = auth.currentUser!.uid;
      if (userData != null) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(auth.currentUser!.uid)
            .set({
          'id': auth.currentUser!.uid,
          'name': userData['name'],
          'email': userData['email'],
          'Url': userData['picture']['data']['url']
        });
        print("hello==============>$userData");
      }

      print("user data =============>$userData");
      Get.offNamed("/home");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
