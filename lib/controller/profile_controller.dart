import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/user_model.dart';

class ProfileController extends GetxController {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  var user = userModel().obs;

  Future getUserDetails() async {
    //simple this also retrun uid,
    //  final snapshot = auth.currentUser;
    var res = await _db.collection('users').doc(auth.currentUser!.uid).get();
//pass model in obs to manage the state if we use simple variable we need to use setstate in initstate
    user.value = userModel.fromJson(res.data()!);
    // print(user.value.email);
  }
  // editProfile() {
  //   _db
  //       .collection('users')
  //       .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //       .snapshots();
  // }
}
