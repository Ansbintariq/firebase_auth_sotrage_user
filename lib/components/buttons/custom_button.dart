import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color? textcolor;
  final Color? bgcolor;
  final String text;
  double? fontsize;
  IconData? icon;
  double? widthSize;
  double? heightSize;
  final Function() onTap;
  CustomButton({
    super.key,
    this.textcolor = Colors.black,
    this.bgcolor,
    required this.text,
    this.widthSize = double.infinity,
    this.heightSize = 40,
    this.fontsize = 14,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: heightSize,
        width: widthSize,
        decoration: BoxDecoration(
          color: bgcolor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textcolor,
              fontSize: fontsize,
            ),
          ),
        ),
      ),
    );
  }
}
