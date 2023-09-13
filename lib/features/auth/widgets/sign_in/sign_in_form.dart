import 'package:as_central_desk/core/utils/form_validation.dart';
import 'package:as_central_desk/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../component/logo_text.dart';
import '../../../../component/rounded_button.dart';
import '../../../../constants/app_constant.dart';
import '../../../../core/common/loader.dart';
import '../../../../core/utils/color_utility.dart';
import '../form_text_field.dart';

class SignInForm extends ConsumerStatefulWidget {
  final Size size;
  final TextTheme textTheme;
  const SignInForm({
    super.key,
    required this.size,
    required this.textTheme,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInFormState();
}

class _SignInFormState extends ConsumerState<SignInForm> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    ref.read(authControllerProvider.notifier).login(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    final validationService = ref.watch(validationServiceProvider);
    final loading = ref.watch(authControllerProvider);
    return Padding(
      padding:
          EdgeInsets.only(top: widget.size.height * 0.05, left: 24, right: 24),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: widget.size.width * 0.1),
                child: Center(
                  child: LogoText(),
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: widget.size.width * 0.1),
                child: CustomFormTextField(
                  controller: emailController,
                  textTheme: widget.textTheme,
                  validator: (val) => validationService.validateEmail(
                    emailController.text.trim(),
                  ),
                  hint: EMAIL_AUTH_HINT,
                  suffixIcon: Icons.person,
                  isPassword: false,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: widget.size.width * 0.1),
                child: CustomFormTextField(
                  controller: passwordController,
                  textTheme: widget.textTheme,
                  validator: (val) => validationService.validatePassword(
                    passwordController.text.trim(),
                  ),
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
                  padding: EdgeInsets.only(right: widget.size.width * 0.05),
                  child: SizedBox(
                    width: 200,
                    child: loading
                        ? const Loader()
                        : RoundedButton(
                            text: BUTTON_LOGIN,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();

                                login();
                              }
                            },
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
