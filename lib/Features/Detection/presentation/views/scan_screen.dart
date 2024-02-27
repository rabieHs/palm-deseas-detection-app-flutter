import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palm_deseas/Features/Detection/presentation/controllers/bloc/scan_palm_bloc.dart';
import 'package:palm_deseas/core/constances.dart';
import 'package:palm_deseas/core/dependecy_injection.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => dp<ScanPalmBloc>()..add(InitializeCamera()),
      child:
          BlocListener<ScanPalmBloc, ScanPalmState>(listener: (context, state) {
        if (state is TakePictureState) {
          showDialog(
              context: context,
              builder: (_context) {
                BlocProvider.of<ScanPalmBloc>(context).add(InitializeCamera());
                return const AlertDialog(
                  content: Text("Picture saved successfully"),
                );
              });
        }
      }, child: BlocBuilder<ScanPalmBloc, ScanPalmState>(
        builder: (context, state) {
          if (state is ScanPalmInitialized) {
            final controller = state.controller;
            return Scaffold(
                body: Stack(
              children: [
                Positioned.fill(
                  child: CameraPreview(
                    controller,
                  ),
                ),
                cameraButton(context, controller, state),
                backButton(context, controller),
              ],
            ));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )),
    );
  }

  Widget backButton(BuildContext context, CameraController controller) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.only(
            top: defaultPadding * 2, left: defaultPadding * 0.5),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            size: 35,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget cameraButton(
      BuildContext context, CameraController controller, ScanPalmState state) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: InkWell(
        onTap: () async {
          BlocProvider.of<ScanPalmBloc>(context)
              .add(TakePicture(controller: controller));
        },
        child: Container(
            margin: EdgeInsets.only(bottom: defaultPadding),
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(width: 3, color: Colors.red),
              borderRadius: BorderRadiusDirectional.circular(50),
            ),
            child: const Center(
              child: Icon(
                Icons.camera_outlined,
                color: Colors.white,
                size: 70,
              ),
            )),
      ),
    );
  }
}
