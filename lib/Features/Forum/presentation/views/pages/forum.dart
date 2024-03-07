// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:palm_deseas/Features/Forum/domain/entities/post.dart';
import 'package:palm_deseas/Features/Forum/presentation/controllers/bloc/post_bloc.dart';
import 'package:palm_deseas/Features/Forum/presentation/views/pages/add_post_screen.dart';
import 'package:palm_deseas/core/dependecy_injection.dart';
import '../../../../../core/common/widgets/exception_widget.dart';
import '../widgets/post_card.dart';

class Forum extends StatelessWidget {
  const Forum({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Forum"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              context: context,
              builder: (context) => Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: const AddPostScreen(),
                  ));
        },
        child: const Icon(Icons.add),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return StreamBuilder(
        stream: dp<PostBloc>().postsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const ExceptionWidget(
                message: "error getting Data",
                image: "assets/images/no_internet_image.png");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data != null) {
              if (snapshot.hasData) {
                final posts = snapshot.data;

                return PostsList(posts: posts!);
              } else {
                return const ExceptionWidget(
                    message: "No Data Found!",
                    image: "assets/images/no_data_image.png");
              }
            } else {
              return const ExceptionWidget(
                  message: "No Data Found!",
                  image: "assets/images/no_data_image.png");
            }
          }
        });
  }
}

class PostsList extends StatelessWidget {
  const PostsList({
    super.key,
    required this.posts,
  });

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return PostCard(post: post);
        });
  }
}
