// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class User extends Equatable {
  String? id;
  final String phone;
  final String name;
  final String email;
  String? photo;
  User({
    this.id,
    required this.phone,
    required this.name,
    required this.email,
    this.photo,
  });

  @override
  List<Object?> get props => [id, phone, name, email, phone];
}
