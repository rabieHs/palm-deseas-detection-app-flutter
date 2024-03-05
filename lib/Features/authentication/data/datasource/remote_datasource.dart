import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:palm_deseas/Features/authentication/data/models/user_model.dart';
import 'package:palm_deseas/core/error/exception.dart';

import '../../../../core/error/failure.dart';

abstract class BaseAuthenticationRemoteDatasource {
  Future<Unit> createUser(UserModel user, String password);
}

class AuthenticationRemoteDatasourceImpl
    implements BaseAuthenticationRemoteDatasource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  AuthenticationRemoteDatasourceImpl(this.firestore, this.auth);
  @override
  Future<Unit> createUser(UserModel userModel, String password) async {
    try {
      final user = await auth.createUserWithEmailAndPassword(
          email: userModel.email, password: password);
      if (user.user != null) {
        userModel.id = user.user!.uid;
        await firestore
            .collection('users')
            .doc(userModel.id)
            .set(userModel.toMap());
        return unit;
      } else {
        throw ServerException();
      }
    } on FirebaseException {
      throw ServerFailure();
    }
  }
}
