import 'dart:async';

import 'package:as_central_desk/theme/app_colors.dart';
import 'package:as_central_desk/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import '../../../../core/common/rounded_button.dart';
import '../../../../core/common/trapezoid_up_cut.dart';
import '../../../../constants/app_constant.dart';

class VerifyEmailTab extends StatefulWidget {
  const VerifyEmailTab({
    super.key,
  });

  @override
  VerifyEmailTabState createState() => VerifyEmailTabState();
}

class VerifyEmailTabState extends State<VerifyEmailTab> {
  late Timer _timer;
  int _delayTime = 30;
  int _resendTime = 30;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _resendTime = _delayTime;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _resendTime--;
      });
      if (_resendTime <= 0) {
        _timer.cancel();
        _delayTime *= 2; // Reset the delay for the next attempt
      }
    });
  }

  void stopTimer() {
    if (_timer.isActive) {
      _timer.cancel();
    }
  }

  void resendEmail() {
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(
        top: size.height * 0.10,
        left: size.width * 0.05,
        right: size.width * 0.05,
        bottom: size.width * 0.20,
      ),
      child: Stack(
        children: [
          TrapezoidUpCut(
            child: Stack(
              children: [
                Material(
                  elevation: 16,
                  child: Container(
                    height: double.infinity,
                    color: Colors.white,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              TEXT_VERIFY_EMAIL_HEADING,
                              style: AppTextStyle.displaySemiBold.copyWith(
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              TEXT_VERIFY_EMAIL_MESSAGE,
                              textAlign: TextAlign.center,
                              style: AppTextStyle.textRegular.copyWith(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            RoundedButton(
                              text: _resendTime != 0
                                  ? ' Resend in $_resendTime seconds'
                                  : BUTTON_RESEND_EMAIL,
                              onPressed: _resendTime != 0 ? null : resendEmail,
                              linearGradient: _resendTime != 0
                                  ? AppColors.roundedButtonDisabledGradient
                                  : AppColors.roundedButtonGradient,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Haven't received Email yet?",
                              style: AppTextStyle.textLight.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
