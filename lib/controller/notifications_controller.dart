import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_getx_localization/controller/users_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../screens/chat_screen/model/chat_user_model.dart';

class NotificationController extends GetxController{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  UserController userController = Get.put(UserController());
   ChatUser? me;

  // for accessing firebase messaging (Push Notification)
   FirebaseMessaging fMessaging = FirebaseMessaging.instance;

  // for getting firebase messaging token
   Future<void> getFirebaseMessagingToken() async {
     await fMessaging.requestPermission();
     await fMessaging.getToken().then((token) {
       if (token != null) {
         userController.updateActiveStatus(true,token);
         log('Push Token: $token');
       }
     });
   }


}