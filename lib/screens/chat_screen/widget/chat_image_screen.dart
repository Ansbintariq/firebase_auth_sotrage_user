import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePreview extends StatelessWidget {
  ImagePreview({Key? key}) : super(key: key);
  final image = Get.arguments[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("$image"),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}
