import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

import '../constances.dart';
import 'styles.dart';

Future<dynamic> showLoadingDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              SizedBox(
                width: defaultPadding * 2,
              ),
              const Text(
                "Loading...",
                style: title3TextStyle,
              )
            ],
          ),
        );
      });
}

void showErrorSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: AwesomeSnackbarContent(
        title: "Error Occured!",
        message: message,
        contentType: ContentType.failure),
  ));
}

void showSuccessSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: AwesomeSnackbarContent(
        title: "Success!", message: message, contentType: ContentType.success),
  ));
}

String? validateField(String? text) {
  if (text == null) {
    return "Field is null";
  } else if (text.isEmpty) {
    return "Field is Empty!";
  } else if (text.length < 3) {
    return "text too short !";
  }
}

String? validateEmailField(String? text) {
  if (text == null) {
    return "Field is null";
  } else if (text.isEmpty) {
    return "Field is Empty!";
  } else if (!text.contains("@")) {
    return "Invalid Email";
  } else if (text.length < 7) {
    return "email is too short !";
  }
}

String? validatePasswordField(String? text) {
  if (text == null) {
    return "Field is null";
  } else if (text.isEmpty) {
    return "Field is Empty!";
  } else if (text.length < 7) {
    return "password must be 7 characters or more";
  }
}

String? validatePhoneField(String? text) {
  if (text == null) {
    return "Field is null";
  } else if (text.isEmpty) {
    return "Field is Empty!";
  } else if (text.length < 7) {
    return "field is too short";
  }
}
