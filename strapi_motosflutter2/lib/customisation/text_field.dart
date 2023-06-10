// customisation/text_field.dart

import 'package:flutter/material.dart';

class Textfield extends StatelessWidget {

  final String hinText;
  final TextStyle hintStyle;
  final Icon icon;
  final TextDirection textDirection;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  const Textfield({super.key, required this.hinText, required this.hintStyle, required this.icon, required this.textDirection, required this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        textDirection: textDirection,
        decoration: InputDecoration(
          fillColor: const Color(0xffFFFFFF),
          filled: true,
          hintText: hinText,
          hintStyle: hintStyle,
          suffixIcon: icon,
          contentPadding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 16
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(
              color: Color(0xFFE57373),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(color: Color(0xFFE57373))
          ),
        ),
      ),
    );
  }
}
