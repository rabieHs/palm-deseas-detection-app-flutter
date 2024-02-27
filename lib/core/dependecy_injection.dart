import 'package:camera/camera.dart';
import 'package:get_it/get_it.dart';
import 'package:palm_deseas/Features/Detection/presentation/controllers/bloc/scan_palm_bloc.dart';
import 'package:palm_deseas/Features/Home/Presentation/controllers/navigation_bloc/navigation_bloc.dart';

final dp = GetIt.instance;

class DependencyInjection {
  static Future<void> init() async {
    dp.registerFactory(() => NavigationBloc());
    dp.registerFactory(() => ScanPalmBloc());

    List<CameraDescription> cameras = await availableCameras();
    CameraController cameraController =
        CameraController(cameras.first, ResolutionPreset.medium);

    dp.registerLazySingleton(() => cameraController);
  }
}
