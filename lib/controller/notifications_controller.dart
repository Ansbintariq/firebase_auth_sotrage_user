import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_getx_localization/controller/users_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';




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

  // for sending push notification
   Future<void> sendPushNotification(
      ChatUser chatUser, String msg) async {
    try {
      final body = {
        "to": chatUser.pushToken,
        "notification": {
          "title": auth.currentUser!.displayName,//our name should be send
          "body": msg,
          "android_channel_id": "chats"
        },
        // "data": {
        //   "some_data": "User ID: ${me.id}",
        // },
      };

      var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
            'key=AAAAfNRU6Y0:APA91bHuz5PFUEVR99HUwlyX2pJuLxwZQwSGA-jyN9R-wQPTcYZTPMePem5RNxbRI1FoTkcftLMMEcYfjdn5V8regraaWI84lRdbTGA49rzXVU8KnUHfIocjQjKPtHLnHYUq8dRh76YI'
          },
          body: jsonEncode(body));
      log('Response status: ${res.statusCode}');
      log('Response body: ${res.body}');
    } catch (e) {
      log('\nsendPushNotificationE: $e');
    }
  }
}