import 'package:as_central_desk/features/auth/widgets/rounded_circular_button.dart';
import 'package:flutter/material.dart';
import '../form_text_field.dart';
import 'sign_in_form.dart';
import '../../../../core/common/logo_text.dart';
import '../../../../core/common/rounded_button.dart';
import '../../../../core/common/trapezoid_down_cut.dart';
import '../../../../constants/app_constant.dart';
import '../../../../core/utils/color_utility.dart';

class SignInTab extends StatelessWidget {
  final Function() onPageDownButtonPressed;

  const SignInTab({
    super.key,
    required this.onPageDownButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(
        top: size.height * 0.0,
        left: size.width * 0.05,
        right: size.width * 0.05,
        bottom: size.width * 0.05,
      ),
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
                      size: size,
                      textTheme: textTheme,
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
              onPressed: onPageDownButtonPressed,
              color: Colors.pinkAccent,
              icon: Icons.arrow_downward,
            ),
          )
        ],
      ),
    );
  }
}
