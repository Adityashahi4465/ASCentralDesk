import 'package:as_central_desk/core/enums/enums.dart';
import 'package:as_central_desk/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../roles/student_profile_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(userProvider)!.role == 'student'
        ? const StudentProfileScreen()
        : Center(child: Text('profile'));
  }
}
