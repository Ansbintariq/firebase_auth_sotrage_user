import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth_getx_localization/helper/data_time_utils.dart';
import 'package:firebase_auth_getx_localization/screens/chat_screen/model/chat_user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import '../../config/images.dart';
import '../../controller/Auth_controller.dart';
import '../../controller/chat_controller.dart';
import 'model/messages_model.dart';
import 'widget/chat_details.dart';
import 'widget/message_card.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.user}) : super(key: key);
  final ChatUser user;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatController chatController = Get.put(ChatController());
  AuthenticationServices controller = Get.put(AuthenticationServices());
  List<Message> _list = [];

  final name = Get.arguments[0];

  final photo = Get.arguments[1];

  FocusNode _focusNode = FocusNode();

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Scroll to the last chat message when entering the chat screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: customMyAppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: chatController.getAllMessages(widget.user),
                  builder: (context, snapshot) {
                    final data = snapshot.data?.docs;
                    _list =
                        data?.map((e) => Message.fromJson(e.data())).toList() ??
                            [];
                    if (_list.isNotEmpty) {
                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: _list.length,
                        padding: const EdgeInsets.only(top: 10, bottom: 40),
                        // physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return MessageCard(
                            message: _list[index],
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Text("say Hi"),
                      );
                    }
                  },
                ),
              ),
              // chat input message
              Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                            onPressed: () async {
                              controller.getImageFromGallery();
                              await controller.uploadImageToFirebase();
                            },
                            icon: Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          )),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        controller: chatController.message,
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    IconButton(
                      onPressed: () async {
                        if (chatController.message.text.isNotEmpty) {
                          _scrollController
                              .animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 200), curve: Curves.easeOut);
                          chatController.sendMessage(
                              widget.user, chatController.message.text);
                          chatController.message.clear();
                        }
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Color(0xff8cc99a),
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget customMyAppBar() => AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  // backgroundImage: NetworkImage("${photo}"),
                  maxRadius: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: FadeInImage.assetNetwork(
                      height: 60,
                      width: 60,
                      placeholder: Images.google,
                      image: "${widget.user.image}",
                      imageErrorBuilder: (c, o, s) => Image.asset(
                        Images.userImage,
                        height: 60,
                        width: 60,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.user.name,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        MyDateUtil.getFormattedTime(
                            context: context, time: widget.user.lastActive),
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      );

}
