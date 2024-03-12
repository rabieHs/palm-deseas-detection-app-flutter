import 'package:flutter/material.dart';

class CustomFilledInputField extends StatelessWidget {
  final TextEditingController controller;
  const CustomFilledInputField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: "Write your comment",
          filled: true,
          fillColor: Colors.grey.shade300,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15))),
    );
  }
}
