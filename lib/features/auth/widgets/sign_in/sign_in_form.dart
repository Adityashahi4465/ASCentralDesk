import 'package:flutter/material.dart';

import '../../../../component/logo_text.dart';
import '../../../../component/rounded_button.dart';
import '../../../../constants/app_constant.dart';
import '../../../../core/utils/color_utility.dart';
import '../form_text_field.dart';

class SignInForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Function() onPressed;
  final Size size;
  final TextTheme textTheme;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const SignInForm({
    super.key,
    required this.formKey,
    required this.onPressed,
    required this.size,
    required this.textTheme,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.05, left: 24, right: 24),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: Center(
                  child: LogoText(),
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: CustomFormTextField(
                  controller: emailController,
                  textTheme: textTheme,
                  validator: (val) {
                    return '';
                  },
                  hint: EMAIL_AUTH_HINT,
                  suffixIcon: Icons.person,
                  isPassword: false,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: CustomFormTextField(
                  controller: passwordController,
                  textTheme: textTheme,
                  validator: (val) {
                    return '';
                  },
                  hint: PASSWORD_AUTH_HINT,
                  suffixIcon: Icons.lock,
                  isPassword: true,
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              Align(
                alignment: FractionalOffset.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(right: size.width * 0.05),
                  child: SizedBox(
                    width: 200,
                    child: RoundedButton(
                      text: BUTTON_LOGIN,
                      onPressed: onPressed,
                      linearGradient: LinearGradient(
                        begin: FractionalOffset.bottomLeft,
                        end: FractionalOffset.topRight,
                        colors: <Color>[
                          Color(getColorHexFromStr("#FE685F")),
                          Color(getColorHexFromStr("#FB578B")),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
