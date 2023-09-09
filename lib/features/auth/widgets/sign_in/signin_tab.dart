import 'package:as_central_desk/features/auth/widgets/rounded_circular_button.dart';
import 'package:flutter/material.dart';
import '../form_text_field.dart';
import 'sign_in_form.dart';
import '/component/logo_text.dart';
import '/component/rounded_button.dart';
import '/component/trapezoid_down_cut.dart';
import '../../../../constants/app_constant.dart';
import '../../../../core/utils/color_utility.dart';

class SignInTab extends StatefulWidget {
 final Function() onFormSubmit;
  final Function() onPageDownButtonPressed;

  const SignInTab({
    super.key,
    required this.onFormSubmit,
    required this.onPageDownButtonPressed,
  });


  @override
  State<SignInTab> createState() => _SignInTabState();
}

class _SignInTabState extends State<SignInTab> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(
          top: size.height * 0.0,
          left: size.width * 0.05,
          right: size.width * 0.05,
          bottom: size.width * 0.05),
      child: Stack(
        children: [
          TrapezoidDownCut(
            child: Stack(
              children: [
                Material(
                  elevation: 16,
                  child: Container(
                    height: double.infinity,
                    color: Colors.white,
                    child: SignInForm(
                      formKey: formKey,
                      onPressed: widget.onFormSubmit,
                      size: size,
                      textTheme: textTheme,
                      emailController: emailController,
                      passwordController: passwordController,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 24,
            right: 12,
            child: RoundedCircularButton(
              onPressed: widget.onPageDownButtonPressed,
              color: Colors.pinkAccent,
              icon: Icons.arrow_downward,
            ),
          )
        ],
      ),
    );
  }
}
