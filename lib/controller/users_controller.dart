import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/user_model.dart';
import '../screens/chat_screen/model/chat_user_model.dart';



class UserController extends GetxController {

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<UserModel>> getAllUsers() async{

    final snapshot= await firestore.collection("users").get();
    print(firestore.collection("users"));
    return snapshot.docs.map((doc) {
      return UserModel.fromSnapshot(doc);
    }).toList();

  }

  // update online or last active status of user
  Future<void> updateActiveStatus(bool isOnline,String token) async {
    firestore.collection('users').doc(auth.currentUser!.uid).update({
      'is_online': "$isOnline",
      'last_active': DateTime.now().millisecondsSinceEpoch.toString(),
      'push_token': token,
    });
  }

}