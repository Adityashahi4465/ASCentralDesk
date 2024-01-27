import 'package:as_central_desk/core/common/rounded_button.dart';
import 'package:as_central_desk/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/loader.dart';
import '../../auth/controller/auth_controller.dart';

class StudentProfileScreen extends ConsumerWidget {
  const StudentProfileScreen({super.key});

  void logOut(WidgetRef ref, BuildContext context) {
    print('logout');
    ref.read(authControllerProvider.notifier).logOut();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(authControllerProvider);
    return Center(
      child: loading
          ? const Loader()
          : RoundedButton(
              onPressed: () => logOut(ref, context),
              text: 'logout from student',
              linearGradient: AppColors.orangeGradient,
            ),
    );
  }
}
