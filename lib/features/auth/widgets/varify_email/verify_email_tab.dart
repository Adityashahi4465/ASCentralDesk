import 'dart:async';

import 'package:as_central_desk/core/utils/snackbar.dart';
import 'package:as_central_desk/features/auth/controller/auth_controller.dart';
import 'package:as_central_desk/features/auth/widgets/rounded_circular_button.dart';
import 'package:as_central_desk/theme/app_colors.dart';
import 'package:as_central_desk/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/common/rounded_button.dart';
import '../../../../core/common/trapezoid_up_cut.dart';
import '../../../../constants/app_constant.dart';

class VerifyEmailTab extends ConsumerStatefulWidget {
  const VerifyEmailTab({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VerifyEmailTabState();
}

class _VerifyEmailTabState extends ConsumerState<VerifyEmailTab>
    with WidgetsBindingObserver {
  late Timer _timer;
  int _delayTime = 30;
  int _resendTime = 0;
  bool _isEmailVerified = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // The app has resumed from the background, check the status again
      checkVerificationStatus();
      print('app resumed');
    }
  }

  void startTimer() {
    _resendTime = _delayTime;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTime <= 0) {
        stopTimer();
        _delayTime *= 2; // Reset the delay for the next attempt
      } else {
        setState(() {
          _resendTime--;
        });
      }
    });
  }

  void stopTimer() {
    if (_timer.isActive) {
      _timer.cancel();
    }
  }

  void checkVerificationStatus() async {
    final user =
        await ref.read(authControllerProvider.notifier).getCurrentUserData();
    print(user!.emailVerified);
    if (user!.emailVerified) {
      // ignore: use_build_context_synchronously
      showCustomSnackbar(
        context,
        TEXT_VERIFY_EMAIL_VERIFICATION_SUCCESS_MESSAGE,
      );
      ref.read(userProvider.notifier).update((state) => user);
    }
  }

  void sandVerificationEmail(String email) {
    ref.read(authControllerProvider.notifier).sandVerificationEmail(
          email: email,
          context: context,
        );
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final user = ref.watch(userProvider)!;
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
                                letterSpacing: 0.8,
                                wordSpacing: 1.0,
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            RoundedButton(
                              text: _resendTime != 0
                                  ? ' Resend in $_resendTime seconds'
                                  : BUTTON_SEND_EMAIL,
                              onPressed: _resendTime != 0
                                  ? null
                                  : () => sandVerificationEmail(user.email),
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
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Refresh',
                                  style: AppTextStyle.textRegular.copyWith(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                RoundedCircularButton(
                                  onPressed: checkVerificationStatus,
                                  color: Colors.pink,
                                  icon: Icons.refresh,
                                ),
                              ],
                            )
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
