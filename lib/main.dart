import 'package:as_central_desk/apis/local_storage_api.dart';
import 'package:as_central_desk/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import 'features/auth/controller/auth_controller.dart';
import 'features/auth/views/auth_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await dotenv.load(fileName: ".env");

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  bool isInitialized = false; // Add a flag to track initialization

  void getUserData(WidgetRef ref) async {
    final user =
        await ref.watch(authControllerProvider.notifier).getCurrentUserData();
    print(user);
    if (user != null) {
      ref.read(userProvider.notifier).update((state) => user);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!isInitialized) {
      // Ensure this block runs only once during initialization
      isInitialized = true;
      getUserData(ref);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    final user = ref.watch(userProvider);
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      routerDelegate: RoutemasterDelegate(
        routesBuilder: (context) {
          if (user != null && user.token.isNotEmpty && user.emailVerified) {
            return loggedInRoute;
          }

          return loggedOutRoute;
        },
      ),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
