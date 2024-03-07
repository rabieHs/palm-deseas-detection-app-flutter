import 'package:flutter/material.dart';

import '../../constances.dart';
import '../styles.dart';

class CustomButton extends StatelessWidget {
  final String title;
  VoidCallback onTap;
  CustomButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding / 2),
      child: MaterialButton(
          color: Colors.green,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          onPressed: onTap,
          child: SizedBox(
            height: defaultPadding * 3.4,
            width: defaultPadding * 15,
            child: Center(
              child: Text(
                title,
                style: buttonTextStyle,
              ),
            ),
          )),
    );
  }
}
