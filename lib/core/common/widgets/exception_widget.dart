import 'package:flutter/material.dart';
import 'package:palm_deseas/core/constances.dart';

class ExceptionWidget extends StatelessWidget {
  final String message;
  final String image;
  const ExceptionWidget({
    Key? key,
    required this.message,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          width: screenWidth(context) * 0.7,
        ),
        Text(
          message,
          style: const TextStyle(
              fontSize: 17, fontWeight: FontWeight.w400, color: Colors.black45),
        )
      ],
    ));
  }
}
