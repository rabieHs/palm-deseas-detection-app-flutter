// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String id;
  final String user_id;
  final String user_name;
  final String user_photo;
  final String content;
  final Timestamp date_published;
  List? likes;

  String? title;

  Post({
    required this.id,
    this.title,
    this.likes,
    required this.user_id,
    required this.user_name,
    required this.user_photo,
    required this.content,
    required this.date_published,
  });

  @override
  List<Object> get props {
    return [
      id,
      user_id,
      user_name,
      user_photo,
      content,
      date_published,
    ];
  }
}
