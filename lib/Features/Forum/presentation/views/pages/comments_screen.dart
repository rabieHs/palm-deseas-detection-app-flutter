// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:palm_deseas/Features/Forum/domain/entities/comment.dart';
import 'package:palm_deseas/Features/Forum/domain/entities/post.dart';
import 'package:palm_deseas/Features/Forum/presentation/controllers/comment_bloc/comment_bloc.dart';
import 'package:palm_deseas/core/common/methods.dart';
import 'package:palm_deseas/core/common/widgets/custom_stream_builder.dart';
import 'package:palm_deseas/core/constances.dart';

import '../../../../../core/common/widgets/exception_widget.dart';
import '../../../../../core/dependecy_injection.dart';
import '../widgets/add_comment_input.dart';
import '../widgets/comment_card.dart';

class CommentsScreen extends StatelessWidget {
  final Post post;
  const CommentsScreen({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommentBloc, CommentState>(listener: (context, state) {
      if (state is LoadingAddCommentState) {
      } else if (state is ErrorAddCommentState) {
        showErrorSnackbar(context, state.message);
      } else if (state is SuccessAddCommentState) {}
    }, builder: (context, state) {
      print(state.runtimeType);

      if (state is ErrorCommentState) {
        return ExceptionWidget(
            message: state.message,
            image: "assets/images/no_internet_image.png");
      } else {
        return SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          // physics: NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: _buildBody(context),
          ),
        );
      }
    });
  }

  Column _buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Center(
            child: Text(
              "Comments",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          height: screenHeight(context) * 0.40,
          child: CustomStreamBuilder(
              builder: (context, comments) {
                return CommentsList(comments: comments);
              },
              stream: BlocProvider.of<CommentBloc>(context).commentStream),
        ),
        AddCommentInput(
          postId: post.id,
        ),
      ],
    );
  }
}

class CommentsList extends StatelessWidget {
  const CommentsList({
    super.key,
    required this.comments,
  });

  final List<Comment> comments;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: comments.length,
        itemBuilder: (context, index) {
          return CommentCard(
            comment: comments[index],
          );
        });
  }
}
