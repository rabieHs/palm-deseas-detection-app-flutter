import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    super.id,
    required super.phone,
    required super.name,
    required super.email,
    super.photo,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        id: map['id'],
        phone: map['phone'],
        name: map['name'],
        email: map['email'],
        photo: map['photo'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photo': photo,
      'phone': phone
    };
  }
}
