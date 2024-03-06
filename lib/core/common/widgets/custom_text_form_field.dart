// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:palm_deseas/core/constances.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType? type;
  String? Function(String?)? validation;
  CustomTextFormField({
    Key? key,
    required this.label,
    required this.controller,
    required this.isPassword,
    this.type,
    this.validation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: defaultPadding / 2, horizontal: defaultPadding / 2),
      child: TextFormField(
        keyboardType: type,
        validator: validation,
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green),
                borderRadius: BorderRadius.circular(10)),
            labelText: label,
            border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green),
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
