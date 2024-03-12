import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palm_deseas/Features/Forum/presentation/controllers/bloc/post_bloc.dart';
import 'package:palm_deseas/Features/authentication/presentation/controllers/bloc/authentication_bloc.dart';
import 'package:palm_deseas/core/common/methods.dart';
import 'package:palm_deseas/core/common/styles.dart';
import 'package:palm_deseas/core/common/widgets/custom_button.dart';
import 'package:palm_deseas/core/common/widgets/custom_text_form_field.dart';
import 'package:palm_deseas/core/common/widgets/multi_line_textfield.dart';
import 'package:palm_deseas/core/constances.dart';

import '../../../../../core/dependecy_injection.dart';

class AddPostScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: ((_context, state) {
        if (state is UploadingPostState) {
          showLoadingDialog(context);
        }
        if (state is ErrorUploadingPostState) {
          showErrorSnackbar(context, state.message);

          Navigator.pop(context);
        }
        if (state is UploadedPostState) {
          showSuccessSnackbar(context, state.message);
          Navigator.pop(context);
        }
      }),
      child: SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Text(
                "Add Post",
                style: title2TextStyle,
              ),
              CustomTextFormField(
                  label: "title",
                  controller: titleController,
                  isPassword: false),
              MultiLineTextFormField(
                  label: "content",
                  controller: contentController,
                  isPassword: false),
              CustomButton(
                  title: "Post",
                  onTap: () {
                    BlocProvider.of<PostBloc>(context).add(UploadPostEvent(
                        title: titleController.text,
                        content: contentController.text,
                        user:
                            BlocProvider.of<AuthenticationBloc>(context).user));

                    Navigator.pop(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
