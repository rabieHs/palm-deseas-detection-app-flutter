import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palm_deseas/Features/Forum/presentation/controllers/bloc/post_bloc.dart';
import 'package:palm_deseas/Features/authentication/presentation/controllers/bloc/authentication_bloc.dart';

import '../../../../../core/constances.dart';
import '../../../domain/entities/post.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      return Padding(
        padding: EdgeInsets.symmetric(
            vertical: defaultPadding / 3, horizontal: defaultPadding),
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          width: screenWidth(context),
          height: 220,
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 0),
                    child: CircleAvatar(),
                  ),
                  _postContent(context),
                ],
              ),
              _postActions(context)
            ],
          ),
        ),
      );
    });
  }

  Column _postContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: screenWidth(context) * 0.69,
          child: const Text(
            "I have A problem with my palm Tress...",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text(
                "By",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                ),
              ),
            ),
            Text(
              post.user_name,
              style: const TextStyle(
                color: Colors.green,
                fontSize: 16,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: screenWidth(context) * 0.65,
          child: const Text(
            "ksdjnfjkdsnfksqmjnflksldknfldssdfjkqdbfdksjqbfqljdhbgjlqhsbgqhjbgjlqskngdsndsjfnlksqjfbqskdmljfbdqskjbkqjgqbl",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Row _postActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                BlocProvider.of<PostBloc>(context).add(LikePostsEvent(post,
                    BlocProvider.of<AuthenticationBloc>(context).user.id!));
              },
              child: Icon(
                Icons.heart_broken,
                color: post.Likes.contains(
                        BlocProvider.of<AuthenticationBloc>(context).user.id)
                    ? Colors.green
                    : Colors.grey,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "${post.Likes.length} Likes",
              style: const TextStyle(
                color: Colors.grey,
              ),
            )
          ],
        ),
        Row(
          children: const [
            Icon(
              Icons.comment,
              color: Colors.grey,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "15 Comment",
              style: TextStyle(
                color: Colors.grey,
              ),
            )
          ],
        ),
        Row(
          children: const [
            Icon(
              Icons.share,
              color: Colors.grey,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "15 Likes",
              style: TextStyle(
                color: Colors.grey,
              ),
            )
          ],
        )
      ],
    );
  }
}
