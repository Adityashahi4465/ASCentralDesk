import 'package:as_central_desk/features/auth/views/auth_screen.dart';
import 'package:as_central_desk/features/auth/views/verify_email_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

import 'features/home/views/home_screen.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (route) => const MaterialPage(
        child: AuthScreen(),
      ),
'/verify-email': (route) => const MaterialPage(
        child: VerifyEmailScreen(),
      ),
});

final loggedInRoute = RouteMap(routes: {
  '/': (route) => const MaterialPage(
        child: HomeScreen(),
      ),
});
