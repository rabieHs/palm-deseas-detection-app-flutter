import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:palm_deseas/Features/authentication/data/models/user_model.dart';
import 'package:palm_deseas/Features/authentication/domain/usecases/login_user_usecase.dart';
import 'package:palm_deseas/core/constances.dart';
import 'package:palm_deseas/core/error/exception.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/user.dart';

abstract class BaseAuthenticationRemoteDatasource {
  Future<Unit> createUser(UserModel user, String password);
  Future<Unit> loginUser(LoginUserUsecaseParameters parameters);
  Future<UserModel> getUser();
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
        userModel.photo = '$photoGeneratorUrl${userModel.name}';
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

  @override
  Future<Unit> loginUser(LoginUserUsecaseParameters parameters) async {
    try {
      final user = await auth.signInWithEmailAndPassword(
          email: parameters.email, password: parameters.password);
      return unit;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        throw WrongPasswordException();
      } else if (e.code == 'email-already-in-use') {
        throw ExistingUserException();
      } else if (e.code == 'too-many-requests') {
        throw ManyRequestsException();
      } else {
        throw ServerException();
      }
    }
  }

  @override
  Future<UserModel> getUser() async {
    try {
      final user = auth.currentUser;
      if (user != null) {
        final uid = user.uid;
        final response = await firestore.collection('users').doc(uid).get();
        final data = response.data();
        if (data != null) {
          Map<String, dynamic> dataMap = data;
          return UserModel.fromMap(dataMap);
        } else {
          throw ServerException();
        }
      } else {
        throw ServerException();
      }
    } catch (_) {
      throw ServerException();
    }
  }
}
