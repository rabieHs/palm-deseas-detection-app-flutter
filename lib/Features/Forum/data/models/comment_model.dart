import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:palm_deseas/Features/Forum/domain/entities/comment.dart';

class CommentModel extends Comment {
  CommentModel(
      {required super.id,
      required super.user_id,
      required super.content,
      required super.userName,
      required super.profile_image,
      required super.date_published});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': user_id,
      'content': content,
      'user_name': userName,
      'profile_image': profile_image,
      'date_published': date_published,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'] as String,
      user_id: map['user_id'] as String,
      content: map['content'] as String,
      userName: map['user_name'] as String,
      profile_image: map['profile_image'] as String,
      date_published: map['date_published'],
    );
  }
}
