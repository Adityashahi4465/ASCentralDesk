import 'package:as_central_desk/features/auth/controller/auth_controller.dart';
import 'package:as_central_desk/features/auth/views/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import 'features/home/views/home_screen.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (route) => const MaterialPage(
        child: AuthScreen(),
      ),
});

final loggedInRoute = RouteMap(routes: {
  '/': (route) => const MaterialPage(
        child: HomeScreen(),
      ),
});

bool isLoggedInGuard(RouteData routeData, WidgetRef ref) {
  if (ref.watch(userProvider) != null) return true;
  return false;
}
