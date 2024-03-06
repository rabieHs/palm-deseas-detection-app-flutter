import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:palm_deseas/Features/authentication/presentation/views/sign_up.dart';

import '../../../../core/common/styles.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/common/widgets/custom_text_form_field.dart';
import '../../../../core/constances.dart';
import '../../domain/entities/user.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
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
                "Login",
                style: title2TextStyle,
              ),
            ),
            _buildFrom(),
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
          Navigator.pop(context);
        },
        child: const Center(
          child: Text(
            "Don't Have An Account? Create Account",
            style: TextStyle(color: Colors.green),
          ),
        ),
      ),
    );
  }

  Center _buildImage(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/images/palm tree-bro.png",
        width: screenWidth(context) * 0.7,
        height: screenWidth(context) * 0.6,
      ),
    );
  }

  SafeArea _buildTitle() {
    return SafeArea(
      child: RichText(
          text: TextSpan(text: "Welcome \n", style: titleTextStyle, children: [
        TextSpan(
            text: "Back!", style: titleTextStyle.copyWith(color: Colors.green))
      ])),
    );
  }

  Form _buildFrom() {
    return Form(
        child: Column(
      children: [
        CustomTextFormField(
          isPassword: false,
          label: "User Email",
          controller: emailController,
        ),
        CustomTextFormField(
          isPassword: true,
          label: "Password",
          controller: passwordController,
        ),
        CustomButton(
          title: "Login",
          onTap: () {},
        ),
      ],
    ));
  }
}
