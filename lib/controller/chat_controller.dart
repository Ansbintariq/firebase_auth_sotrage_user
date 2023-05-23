import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_getx_localization/screens/chat_screen/model/messages_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../screens/chat_screen/model/chat_user_model.dart';

class ChatController extends GetxController {
  TextEditingController message = TextEditingController();


  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final pickImage = Rxn<File>();
  // for storing self information
  static late ChatUser me;

// creating a chat room with unique id
  String getConversationId(String id) =>
      auth.currentUser!.uid.hashCode <= id.hashCode
          ? '${auth.currentUser!.uid}_$id'
          : '${id}_${auth.currentUser!.uid}';



// get all message or chat between two users on basis of room id
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(ChatUser user) {
    return firestore.collection('chats/${getConversationId(user.id)}/messages/').snapshots();
  }//creating a chat room with unique id


  // this function is use to send all messages
  Future<void> sendMessage(ChatUser chatUser,String msg,Type type) async{
    final time=DateTime.now().millisecondsSinceEpoch.toString();
    final path=firestore.collection('chats/${getConversationId(chatUser.id)}/messages/');
    final Message message =Message(toId: chatUser.id, msg: msg, read: "", type: type, fromId: auth.currentUser!.uid, sent: time);
    await path.doc(time).set(message.toJson());
  }

  Future getImageFromGallery(ChatUser chatUser) async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      pickImage.value = File(image.path);
     await sendChatImage(chatUser, File(pickImage.value!.path));
      update();
    } else {
      //  print("no image selected");
    }
  }
  // this function is use to upload/send image in chat
  Future sendChatImage(ChatUser chatUser,File file) async{

    final ext=file.path.split('.').last;
    final time=DateTime.now().millisecondsSinceEpoch.toString();
    //file storage with path
final storage= FirebaseStorage.instance;
    final ref=storage.ref().child('images/${getConversationId(chatUser.id)}/${auth.currentUser!.uid}/$time.$ext');

    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    final imageUrl = await ref.getDownloadURL();
    await sendMessage(chatUser, imageUrl, Type.image);
  }
  // update online or last active status of user


}
