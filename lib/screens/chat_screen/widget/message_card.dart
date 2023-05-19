import 'package:firebase_auth_getx_localization/helper/data_time_utils.dart';
import 'package:firebase_auth_getx_localization/screens/chat_screen/model/messages_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/Auth_controller.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({Key? key, required this.message}) : super(key: key);
  final Message message;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  AuthenticationServices authcontroller = Get.put(AuthenticationServices());

  @override
  Widget build(BuildContext context) {
    return authcontroller.auth.currentUser!.uid == widget.message.fromId
        ? _greenMessage()
        : _blueMessage();
  }

  Widget _blueMessage() {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                  color: Color(0xffeeebeb)),
              padding: const EdgeInsets.all(12),
              child: Text(
                widget.message.msg,
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              MyDateUtil.getFormattedTime(context: context, time: widget.message.sent),
              style: const TextStyle(fontSize: 10),
            ),
          )
        ],
      ),
    );
  }

  Widget _greenMessage() {
    return   Padding(
      padding: const EdgeInsets.only(left: 60,right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                  color: Colors.blue[200]),

              padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 10),
              child: Text(
                widget.message.msg,
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              alignment: Alignment.bottomRight,
              child: Text(

                MyDateUtil.getFormattedTime(context: context, time: widget.message.sent),
                style: const TextStyle(fontSize: 10),
              ),
            ),
          )
        ],
      ),
    );;
  }
}
