import 'package:flutter/material.dart';

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: screenWidth(context) * 0.69,
                      child: Text(
                        "I have A problem with my palm Tress...",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
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
                        Container(
                          child: Text(
                            post.user_name,
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
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
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.heart_broken,
                      color: Colors.green,
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
            )
          ],
        ),
      ),
    );
  }
}
