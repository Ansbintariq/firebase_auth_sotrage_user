import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth_getx_localization/helper/data_time_utils.dart';
import 'package:firebase_auth_getx_localization/screens/chat_screen/model/messages_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/images.dart';
import '../../../controller/Auth_controller.dart';
import 'chat_image_screen.dart';

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
    //widget.message.fromId retrieves the sender's ID from the widget.message object.
    return authcontroller.auth.currentUser!.uid == widget.message.fromId
        ? _greenMessage()
        : _blueMessage();
  }

  Widget _blueMessage() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
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
                child: widget.message.type == Type.text
                    ? Text(
                        widget.message.msg,
                        style: const TextStyle(fontSize: 15),
                      )
                    :
                    // FadeInImage.assetNetwork(
                    //
                    //    fit: BoxFit.cover,
                    //    placeholder: Images.userImage,
                    //    image:
                    //    "${widget.message.msg}",
                    //    imageErrorBuilder: (c, o, s) =>
                    //        Image.asset(Images.google),
                    //  )

                    GestureDetector(
                        onTap: () {
                          Get.to(() => ImagePreview(),
                              arguments: [widget.message.msg]);
                        },
                        child: CachedNetworkImage(
                          height: MediaQuery.of(context).size.height * .3,
                          width: MediaQuery.of(context).size.width * .6,
                          imageUrl: "${widget.message.msg}",
                          errorWidget: (c, o, s) => Icon(
                            Icons.image_rounded,
                            size: 100,
                          ),
                          fit: BoxFit.cover,
                        ),
                      )),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              MyDateUtil.getFormattedTime(
                  context: context, time: widget.message.sent),
              style: const TextStyle(fontSize: 10),
            ),
          )
        ],
      ),
    );
  }

  Widget _greenMessage() {
    return Padding(
      padding: const EdgeInsets.only(left: 60, right: 10),
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
              padding: widget.message.type == Type.text
                  ? const EdgeInsets.symmetric(horizontal: 10, vertical: 10)
                  : const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: widget.message.type == Type.text
                  ? Text(
                      widget.message.msg,
                      style: const TextStyle(fontSize: 15),
                    )
                  : GestureDetector(
                      onTap: () {
                        Get.to(() => ImagePreview(),
                            arguments: [widget.message.msg]);
                      },
                      child: CachedNetworkImage(
                        height: MediaQuery.of(context).size.height * .30,
                        width: MediaQuery.of(context).size.width * .6,
                        imageUrl: "${widget.message.msg}",
                        errorWidget: (c, o, s) => Icon(
                          Icons.image_rounded,
                          size: 100,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              alignment: Alignment.bottomRight,
              child: Text(
                MyDateUtil.getFormattedTime(
                    context: context, time: widget.message.sent),
                style: const TextStyle(fontSize: 10),
              ),
            ),
          )
        ],
      ),
    );
    ;
  }
}
