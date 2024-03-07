// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palm_deseas/Features/Home/Presentation/views/home.dart';
import 'package:palm_deseas/Features/authentication/presentation/controllers/bloc/authentication_bloc.dart';
import 'package:palm_deseas/Features/authentication/presentation/views/login.dart';

import 'package:palm_deseas/core/common/styles.dart';
import 'package:palm_deseas/core/constances.dart';

import '../../../../core/common/methods.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/common/widgets/custom_text_form_field.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
      if (state is LoadingCreationUserState) {
        showLoadingDialog(context);
      } else if (state is ErrorCreationUserState) {
        Navigator.pop(context);
        showErrorSnackbar(context, state.message);
      } else if (state is SuccessCreationUserState) {
        BlocProvider.of<AuthenticationBloc>(context).add(GetUserEvent());
      }
      if (state is SuccessGetUsertate) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
      }
    }, builder: (context, state) {
      return Scaffold(
        body: _buildBody(context),
      );
    });
  }

  SingleChildScrollView _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            _buildImage(context),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Create an Account",
                style: title2TextStyle,
              ),
            ),
            _buildFrom(context),
            _buildLoginNavigationText(context)
          ],
        ),
      ),
    );
  }

  Padding _buildLoginNavigationText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Login()));
        },
        child: const Center(
          child: Text(
            "Already Have An Account? Login",
            style: TextStyle(color: Colors.green),
          ),
        ),
      ),
    );
  }

  Center _buildImage(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/images/palm tree-pana.png",
        width: screenWidth(context) * 0.65,
        height: screenWidth(context) * 0.55,
      ),
    );
  }

  SafeArea _buildTitle() {
    return SafeArea(
      bottom: false,
      child: RichText(
          text: TextSpan(
              text: "Welcome to\n",
              style: titleTextStyle,
              children: [
            TextSpan(
                text: "Palma",
                style: titleTextStyle.copyWith(color: Colors.green))
          ])),
    );
  }

  Form _buildFrom(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextFormField(
              validation: validateField,
              isPassword: false,
              label: "User Name",
              controller: nameController,
            ),
            CustomTextFormField(
              validation: validateEmailField,
              isPassword: false,
              label: "User Email",
              controller: emailController,
            ),
            CustomTextFormField(
              validation: validatePhoneField,
              type: TextInputType.number,
              isPassword: false,
              label: "Phone Number ",
              controller: phoneController,
            ),
            CustomTextFormField(
              validation: validatePasswordField,
              isPassword: true,
              label: "Password",
              controller: passwordController,
            ),
            CustomButton(
              title: "Register",
              onTap: () {
                if (formKey.currentState!.validate()) {
                  BlocProvider.of<AuthenticationBloc>(context).add(
                      CreateUserEvent(
                          email: emailController.text,
                          name: nameController.text,
                          password: passwordController.text,
                          phoneNumber: phoneController.text));
                }
              },
            ),
          ],
        ));
  }
}
