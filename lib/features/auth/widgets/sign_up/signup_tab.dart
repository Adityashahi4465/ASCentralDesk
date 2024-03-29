import 'package:as_central_desk/core/common/trapezoid_up_cut.dart';
import 'package:flutter/material.dart';
import '../rounded_circular_button.dart';
import 'sign_up_form.dart';

class SignUpTab extends StatelessWidget {
  final Function() onPageUpButtonPressed;

  const SignUpTab({
    super.key,
    required this.onPageUpButtonPressed,
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
        bottom: size.width * 0.0,
      ),
      child: Stack(
        children: [
          TrapezoidUpCut(
            child: Stack(
              children: <Widget>[
                Material(
                  elevation: 16,
                  child: Container(
                    height: double.infinity,
                    color: Colors.white,
                    child: SignUpForm(
                      size: size,
                      textTheme: textTheme,
                    ),
                  ),
                ),
              ],
            ),
          ),
          /* TOP ARROW BUTTON TO MOVE TO SIGN IN PAGE */
          Positioned(
            top: 24,
            left: 12,
            child: RoundedCircularButton(
              onPressed: onPageUpButtonPressed,
              color: Colors.pinkAccent,
              icon: Icons.arrow_upward,
            ),
          ),
        ],
      ),
    );
  }
}
