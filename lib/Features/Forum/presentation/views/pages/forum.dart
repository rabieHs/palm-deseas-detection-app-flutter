// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:palm_deseas/Features/Forum/domain/entities/post.dart';
import 'package:palm_deseas/Features/Forum/presentation/controllers/bloc/post_bloc.dart';
import 'package:palm_deseas/Features/Forum/presentation/views/pages/add_post_screen.dart';
import 'package:palm_deseas/core/dependecy_injection.dart';

import '../../../../../core/common/widgets/custom_stream_builder.dart';
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
              isScrollControlled: true,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              context: context,
              builder: (context) => Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: AddPostScreen(),
                  ));
        },
        child: const Icon(Icons.add),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return CustomStreamBuilder(
      stream: BlocProvider.of<PostBloc>(context).postsStream,
      builder: (context, posts) {
        return PostsList(posts: posts);
      },
    );
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
