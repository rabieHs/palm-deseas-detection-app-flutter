import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palm_deseas/Features/Detection/presentation/controllers/bloc/scan_palm_bloc.dart';
import 'package:palm_deseas/Features/Forum/presentation/controllers/bloc/post_bloc.dart';
import 'package:palm_deseas/Features/Home/Presentation/controllers/navigation_bloc/navigation_bloc.dart';
import 'package:palm_deseas/Features/Home/Presentation/views/home.dart';
import 'package:palm_deseas/Features/authentication/presentation/controllers/bloc/authentication_bloc.dart';
import 'package:palm_deseas/Features/authentication/presentation/views/sign_up.dart';
import 'package:palm_deseas/core/dependecy_injection.dart';
import 'package:palm_deseas/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  DependencyInjection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => dp<PostBloc>()..add(GetAllPostsEvent())),
          BlocProvider(create: (context) => dp<NavigationBloc>()),
          BlocProvider(create: (context) => dp<ScanPalmBloc>()),
          BlocProvider(
              create: (context) =>
                  dp<AuthenticationBloc>()..add(GetUserEvent()))
        ],
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(primarySwatch: Colors.green),
              home: state is ErrorGetUserUserState ? SignUp() : const Home(),
            );
          },
        ));
  }
}
