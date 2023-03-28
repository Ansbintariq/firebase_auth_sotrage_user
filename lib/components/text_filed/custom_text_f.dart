import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String headerText;
  final String hintText;
  final String labelText;
  final TextStyle? headerStyle;
  final TextInputAction? inputAction;
  final TextInputType? inputType;
  final FormFieldSetter<String>? onChanged;
  final FormFieldValidator<String>? validator;
  bool obscureText;
  final IconData? suffixIcon;
  final IconData? prefixIcon;

  final Function()? suffixTap;
  final Function()? prefixTap;
  final double feildHeight;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  CustomTextField(
      {super.key,
      this.headerText = "",
      this.headerStyle,
      this.hintText = "",
      this.labelText = "",
      this.inputAction,
      this.obscureText = false,
      this.inputType,
      this.onChanged,
      this.validator,
      this.controller,
      this.feildHeight = 45.0,
      this.focusNode,
      this.suffixIcon,
      this.prefixIcon,
      this.suffixTap,
      this.prefixTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headerText == null
            ? const SizedBox()
            : Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: headerText.isEmpty ? 0.0 : 4.0,
                    vertical: headerText.isEmpty ? 0.0 : 4.0),
                child: Text(
                  headerText,
                  style: headerStyle,
                ),
              ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 197, 195, 195),
                blurRadius: 15.0, // soften the shadow
                spreadRadius: 5.0, //extend the shadow
                offset: Offset(
                  5.0, // Move to right 5  horizontally
                  5.0, // Move to bottom 5 Vertically
                ),
              )
            ],
          ),
          child: TextFormField(
            keyboardType: inputType,
            textInputAction: inputAction,
            obscureText: obscureText,
            onChanged: onChanged,
            focusNode: focusNode,
            controller: controller,
            validator: validator,
            decoration: InputDecoration(
                hintText: hintText,
                contentPadding: const EdgeInsets.all(10.0),
                labelText: labelText,
                fillColor: Colors.white,
                filled: true,
                suffixIcon: suffixIcon == null
                    ? null
                    : IconButton(
                        onPressed: suffixTap,
                        icon: Icon(
                          suffixIcon,
                        )),
                prefixIcon: prefixIcon == null
                    ? null
                    : IconButton(
                        onPressed: prefixTap,
                        icon: Icon(
                          prefixIcon,
                        )),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 172, 171, 171), width: 1.8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.8),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 255, 36, 36), width: 1.8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 249, 43, 43), width: 1.8),
                )),
          ),
        ),
      ],
    );
  }
}
