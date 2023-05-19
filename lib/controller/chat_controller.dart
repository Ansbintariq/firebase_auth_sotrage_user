import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_getx_localization/screens/chat_screen/model/messages_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/chat_screen/model/chat_user_model.dart';

class ChatController extends GetxController {
  TextEditingController message = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
//creating a chat room with unique id
  String getConversationId(String id) =>
      auth.currentUser!.uid.hashCode <= id.hashCode
          ? '${auth.currentUser!.uid}_$id'
          : '${id}_${auth.currentUser!.uid}';
// get all message or chat between two users on basis of room id
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(ChatUser user) {

    return firestore.collection('chats/${getConversationId(user.id)}/messages/').snapshots();

  }

  // this function is use to send all messages
  Future<void> sendMessage(ChatUser chatUser,String msg) async{
    final time=DateTime.now().millisecondsSinceEpoch.toString();
    final path=firestore.collection('chats/${getConversationId(chatUser.id)}/messages/');
    final Message message =Message(toId: chatUser.id, msg: msg, read: "", type: Type.text, fromId: auth.currentUser!.uid, sent: time);
    await path.doc(time).set(message.toJson());


  }
  Future<void> sendChatImage(ChatUser chatUser,File file) async{

  }

}
