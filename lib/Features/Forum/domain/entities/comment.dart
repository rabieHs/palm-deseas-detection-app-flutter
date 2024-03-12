// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final String id;
  final String user_id;
  final String content;
  final String userName;
  final String profile_image;
  final Timestamp date_published;
  const Comment({
    required this.id,
    required this.user_id,
    required this.content,
    required this.userName,
    required this.profile_image,
    required this.date_published,
  });
  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, user_id, content, userName, profile_image, date_published];
}
