// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:palm_deseas/Features/Forum/presentation/controllers/comment_bloc/comment_bloc.dart';
import 'package:palm_deseas/Features/authentication/presentation/controllers/bloc/authentication_bloc.dart';

import '../../../../../core/common/widgets/custome_filled_input_field.dart';
import '../../../../../core/constances.dart';

class AddCommentInput extends StatelessWidget {
  final String postId;
  final TextEditingController inputCommentController = TextEditingController();
  AddCommentInput({
    Key? key,
    required this.postId,
  }) : super(key: key);

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
          InkWell(
            onTap: () {
              print(inputCommentController.text);
              BlocProvider.of<CommentBloc>(context).add(AddCommentsEvent(
                  postId: postId,
                  user: BlocProvider.of<AuthenticationBloc>(context).user,
                  content: inputCommentController.text));
            },
            child: const CircleAvatar(
              radius: 24,
              child: Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
