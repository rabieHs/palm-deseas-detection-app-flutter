import 'package:flutter/material.dart';
import 'package:palm_deseas/core/common/styles.dart';

import '../../../../../core/constances.dart';
import '../../../domain/entities/comment.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;
  const CommentCard({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            const CircleAvatar(),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  comment.userName,
                  style: simpleTitleTextStyle,
                ),
                SizedBox(
                  width: screenWidth(context) * 0.6,
                  child: Text(
                    comment.content,
                    style: simpleTextStyle,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
