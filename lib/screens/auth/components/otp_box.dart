import 'package:flutter/material.dart';

class OtpBox extends StatelessWidget {
  final TextEditingController? controller;
  OtpBox({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      width: 50,
      child: TextField(
        // autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        cursorColor: Theme.of(context).primaryColor,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            counterText: '',
            hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
