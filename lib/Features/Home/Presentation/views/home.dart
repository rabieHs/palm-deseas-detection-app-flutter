import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palm_deseas/Features/Blog/presentation/views/blog.dart';
import 'package:palm_deseas/Features/Detection/presentation/views/scan_screen.dart';
import 'package:palm_deseas/Features/Forum/presentation/views/pages/forum.dart';
import 'package:palm_deseas/Features/Home/Presentation/controllers/navigation_bloc/navigation_bloc.dart';
import 'package:palm_deseas/Features/authentication/presentation/controllers/bloc/authentication_bloc.dart';
import 'package:palm_deseas/core/dependecy_injection.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
      print(BlocProvider.of<AuthenticationBloc>(context).user.id);
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          elevation: 0,
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                // constraints: BoxConstraints(maxHeight: double.infinity),
                // useRootNavigator: true,
                context: context,
                builder: ((context) => ScanScreen()));
          },
          child: Icon(Icons.camera_outlined),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.green,
            currentIndex: state.navigationState,
            onTap: (index) {
              // print(state.navigationState);
              BlocProvider.of<NavigationBloc>(context)
                  .add(HandleNavigation(index: index));
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.tips_and_updates_rounded), label: "Forum"),
              BottomNavigationBarItem(icon: Icon(Icons.topic), label: "Blog"),
            ]),
        body: IndexedStack(
          index: state.navigationState,
          children: const [
            Forum(),
            Blog(),
          ],
        ),
      );
    });
  }
}
