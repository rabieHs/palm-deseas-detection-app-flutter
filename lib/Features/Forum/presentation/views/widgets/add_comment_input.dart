// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../../core/common/widgets/custome_filled_input_field.dart';
import '../../../../../core/constances.dart';

class AddCommentInput extends StatelessWidget {
  final TextEditingController inputCommentController = TextEditingController();
  AddCommentInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: defaultPadding).copyWith(right: 0),
      width: screenWidth(context),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenWidth(context) * 0.72,
            child: CustomFilledInputField(
              controller: inputCommentController,
            ),
          ),
          const CircleAvatar(
            radius: 24,
            child: Icon(
              Icons.send,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
