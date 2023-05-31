import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_getx_localization/controller/Auth_controller.dart';
import 'package:get/get.dart';

import '../model/user_model.dart';

class ProfileController extends GetxController {
  AuthenticationServices controller = Get.put(AuthenticationServices());
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  var user = UserModel().obs;
  RxBool loading = false.obs;

  Future getUserDetails() async {
    //simple this also retrun uid,
    var res = await _db.collection('users').doc(auth.currentUser!.uid).get();
//pass model in obs to manage the state if we use simple variable we need to use setstate in initstate
    user.value = UserModel.fromJson(res.data()!);
    // print(user.value.email);
  }
  // editProfile() {
  //   _db
  //       .collection('users')
  //       .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //       .snapshots();
  // }

  Future<void> updateUser(UserModel user) async {
    loading.value = true;
    if (controller.pickImage.value != null) {
      await controller.uploadImageToFirebase();
    }
    {
      print('image===============${controller.pickImage.value}');
    }
    await _db.collection('users').doc(auth.currentUser!.uid).update({
      'name': user.name,
      'email': user.email,
      'phone': user.phone,
      'Url': controller.url.value
    });

    update();
    await getUserDetails();

    loading.value = false;
  }
}
