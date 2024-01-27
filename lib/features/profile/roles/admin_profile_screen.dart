import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/loader.dart';
import '../../auth/controller/auth_controller.dart';

class AdminProfileScreen extends ConsumerWidget {
  const AdminProfileScreen({super.key});

  void logOut(WidgetRef ref, BuildContext context) {
    print('logout');
    ref.read(authControllerProvider.notifier).logOut();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(authControllerProvider);
    return Center(
      child: GestureDetector(
        onTap: () => logOut(ref, context),
        child: loading ? const Loader() : const Text('logout'),
      ),
    );
  }
}
