// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:palm_deseas/Features/Forum/data/models/post_model.dart';

import '../../../../core/error/exception.dart';

abstract class BasePostRemoteDatasource {
  Future<List<PostModel>> getAllPosts();
  Stream<List<PostModel>> streamPosts();
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
    print("startig fetching");
    return firestore.collection("posts").snapshots().map((snapshot) {
      final docs = snapshot.docs;
      final postsList = docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return PostModel.fromJson(data);
      }).toList();
      return postsList;
    });
  }
}
