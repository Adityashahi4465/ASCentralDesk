import 'package:as_central_desk/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          // user.email,
          'Home',
        ),
      ),
    );
  }
}
