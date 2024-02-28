import 'package:palm_deseas/Features/Forum/domain/entities/post.dart';

class PostModel extends Post {
  PostModel(super.Likes,
      {required super.id,
      required super.user_id,
      required super.user_name,
      required super.user_photo,
      required super.content,
      required super.date_published});

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      PostModel(json["likes"],
          id: json["id"],
          user_id: json["user_id"],
          user_name: json["user_name"],
          user_photo: json["user_photo"],
          content: json["content"],
          date_published: json["date_published"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": user_id,
        "user_name": user_name,
        "user_photo": user_photo,
        "content": content,
        "date_published": date_published,
        "likes": Likes,
      };
}
