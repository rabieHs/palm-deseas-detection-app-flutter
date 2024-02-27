// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'scan_palm_bloc.dart';

abstract class ScanPalmEvent extends Equatable {}

class InitializeCamera extends ScanPalmEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class TakePicture extends ScanPalmEvent {
  final CameraController controller;
  TakePicture({
    required this.controller,
  });
  @override
  List<Object?> get props => [controller];
}
