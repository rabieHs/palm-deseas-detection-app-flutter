import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:palm_deseas/Features/Detection/presentation/controllers/bloc/scan_palm_bloc.dart';
import 'package:palm_deseas/Features/Forum/data/datasource/post_remote_datasouce.dart';
import 'package:palm_deseas/Features/Forum/data/repository/post_repository_impl.dart';
import 'package:palm_deseas/Features/Forum/domain/repository/base_post_repository.dart';
import 'package:palm_deseas/Features/Forum/domain/usecases/get_all_posts_usecase.dart';
import 'package:palm_deseas/Features/Forum/domain/usecases/stream_posts_usecase.dart';
import 'package:palm_deseas/Features/Forum/presentation/controllers/bloc/post_bloc.dart';
import 'package:palm_deseas/Features/Home/Presentation/controllers/navigation_bloc/navigation_bloc.dart';
import 'package:palm_deseas/core/common/failure_handler.dart';
import 'package:palm_deseas/core/networking/network_info.dart';

final dp = GetIt.instance;

class DependencyInjection {
  static Future<void> init() async {
    dp.registerLazySingleton(() => InternetConnectionChecker());
    final firestore = FirebaseFirestore.instance;
    dp.registerLazySingleton<FirebaseFirestore>(() => firestore);
    dp.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(connectionChecker: dp()));
    // Bloc

    dp.registerFactory(() => NavigationBloc());
    dp.registerFactory<PostBloc>(() => PostBloc(dp(), dp(), FailureHandler()));

    // Datarouces
    dp.registerLazySingleton<BasePostRemoteDatasource>(
        () => PostRemoteDatasourceImpl(firestore: dp<FirebaseFirestore>()));

    // Repository

    dp.registerLazySingleton<BasePostRepository>(() => PostrepositoryImpl(
        remoteDatasource: dp<BasePostRemoteDatasource>(), networkInfo: dp()));

    // Usecases
    dp.registerLazySingleton(() => GetAllPostsUsecase(postRepository: dp()));
    dp.registerLazySingleton(() => StreamPostsUsecase(repository: dp()));
    //! External

    final handler = FailureHandler();

    dp.registerLazySingleton<FailureHandler>(() => handler);
    List<CameraDescription> cameras = await availableCameras();

    dp.registerFactory(
        () => CameraController(cameras.first, ResolutionPreset.medium));
    dp.registerFactory(() => ScanPalmBloc());
  }
}
