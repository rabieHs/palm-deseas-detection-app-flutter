import 'package:flutter/material.dart';
import 'package:palm_deseas/Features/Home/Presentation/views/home.dart';
import 'package:palm_deseas/core/dependecy_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const Home(),
    );
  }
}
