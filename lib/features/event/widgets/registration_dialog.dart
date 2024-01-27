import 'package:as_central_desk/core/common/loader.dart';
import 'package:as_central_desk/core/common/rounded_button.dart';
import 'package:as_central_desk/features/event/controller/event_controller.dart';
import 'package:as_central_desk/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistrationDialog extends ConsumerWidget {
  final VoidCallback onRegisterPressed;

  const RegistrationDialog({
    Key? key,
    required this.onRegisterPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Register Now',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Share your profile to register for the event.',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 16.0),
       ref.watch(eventControllerProvider) ? const Loader() :     RoundedButton(
              onPressed: onRegisterPressed,
              text: 'Share Your Profile',
              linearGradient: AppColors.lightPinkGradient,
            ),
          ],
        ),
      ),
    );
  }
}
