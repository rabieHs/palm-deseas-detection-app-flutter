import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:palm_deseas/core/dependecy_injection.dart';
import 'package:flutter/material.dart';
part 'scan_palm_event.dart';
part 'scan_palm_state.dart';

class ScanPalmBloc extends Bloc<ScanPalmEvent, ScanPalmState> {
  ScanPalmBloc() : super(ScanPalmInitial()) {
    on<ScanPalmEvent>((event, emit) {});
    on<InitializeCamera>((event, emit) async {
      final cameraController = dp<CameraController>();
      await cameraController.initialize().whenComplete(
          () => emit(ScanPalmInitialized(controller: cameraController)));
    });

    on<TakePicture>((event, emit) async {
      final cameraController = event.controller;
      if (!cameraController.value.isTakingPicture) {
        final file = await cameraController.takePicture();

        if (!cameraController.value.isTakingPicture) {
          final imageFile = File(file.path);
          emit(TakePictureState(imagePath: imageFile.path));
        } else {}
      }
    });
  }
}
