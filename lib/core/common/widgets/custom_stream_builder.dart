import 'package:flutter/material.dart';

import 'exception_widget.dart';

class CustomStreamBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, dynamic data) builder;
  final Stream stream;
  const CustomStreamBuilder({
    Key? key,
    required this.builder,
    required this.stream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
/*             return const ExceptionWidget(
                message: "error getting Data",
                image: "assets/images/no_internet_image.png"); */
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data != null) {
              if (snapshot.hasData) {
                final posts = snapshot.data!;

                if (posts.isEmpty) {
                  return const ExceptionWidget(
                      message: "No Data Found!",
                      image: "assets/images/no_data_image.png");
                }

                return builder(context, posts);
              } else {
                return const ExceptionWidget(
                    message: "No Data Found!",
                    image: "assets/images/no_data_image.png");
              }
            } else {
              return const ExceptionWidget(
                  message: "No Data Found!",
                  image: "assets/images/no_data_image.png");
            }
          }
        });
  }
}
