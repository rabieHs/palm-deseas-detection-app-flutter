// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:palm_deseas/Features/Forum/data/models/comment_model.dart';

import 'package:palm_deseas/Features/Forum/data/models/post_model.dart';
import 'package:palm_deseas/Features/Forum/domain/usecases/like_post_usecase.dart';

import '../../../../core/error/exception.dart';

abstract class BasePostRemoteDatasource {
  Future<Unit> uploadPost(PostModel postModel);
  Future<Unit> uploadComment(CommentModel commentModel, String postId);
  Future<List<PostModel>> getAllPosts();
  Stream<List<PostModel>> streamPosts();
  Future<Unit> likePost(LikePostusecaseParameters parameters);
  Stream<List<CommentModel>> streamPostComments(String postId);
}

class PostRemoteDatasourceImpl implements BasePostRemoteDatasource {
  final FirebaseFirestore firestore;
  PostRemoteDatasourceImpl({
    required this.firestore,
  });
  @override
  Future<List<PostModel>> getAllPosts() async {
    final snapshot = await firestore.collection("posts").get();

    final docs = snapshot.docs;
    return docs.map((doc) {
      try {
        Map<String, dynamic> data = doc.data();
        return PostModel.fromJson(data);
      } on FirebaseException catch (_) {
        throw ServerException();
      }
    }).toList();
  }

  @override
  Stream<List<PostModel>> streamPosts() {
    return firestore.collection("posts").snapshots().map((snapshot) {
      final docs = snapshot.docs;

      final postsList = docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        final model = PostModel.fromJson(data);
        return PostModel.fromJson(data);
      }).toList();
      return postsList;
    });
  }

  @override
  Future<Unit> likePost(LikePostusecaseParameters parameters) async {
    try {
      if (parameters.post.likes!.contains(parameters.uid)) {
        await firestore.collection('posts').doc(parameters.post.id).update({
          'likes': FieldValue.arrayRemove([parameters.uid])
        });
      } else {
        await firestore.collection('posts').doc(parameters.post.id).update({
          'likes': FieldValue.arrayUnion([parameters.uid])
        });
      }
      return unit;
    } on FirebaseException catch (_) {
      throw ServerException();
    }
  }

  @override
  Stream<List<CommentModel>> streamPostComments(String postId) {
    try {
      return firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .snapshots()
          .map((snapshot) {
        final docs = snapshot.docs;
        if (docs.isEmpty) {
          return [];
        }
        return docs.map((doc) {
          Map<String, dynamic> commentData = doc.data();
          return CommentModel.fromMap(commentData);
        }).toList();
      });
    } on FirebaseException catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<Unit> uploadPost(PostModel postModel) async {
    try {
      await firestore
          .collection("posts")
          .doc(postModel.id)
          .set(postModel.toJson());
      return unit;
    } on FirebaseException catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<Unit> uploadComment(CommentModel commentModel, String postId) async {
    try {
      await firestore
          .collection("posts")
          .doc(postId)
          .collection("comments")
          .doc(commentModel.id)
          .set(commentModel.toMap());
      return unit;
    } on FirebaseException catch (_) {
      throw ServerException();
    }
  }
}
