// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'scan_palm_bloc.dart';

@immutable
abstract class ScanPalmState {}

class ScanPalmInitial extends ScanPalmState {}

class ScanPalmInitialized extends ScanPalmState {
  final CameraController controller;
  ScanPalmInitialized({
    required this.controller,
  });
}

class TakePictureState extends ScanPalmState {
  String imagePath;
  TakePictureState({
    required this.imagePath,
  });
}
