import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class Navigation {
  static void navigateToBack(BuildContext context) {
    Routemaster.of(context).pop();
  }
  static void navigateToHome(BuildContext context) {
    Routemaster.of(context).push('/');
  }

  static void navigateToNewComplaintScreen(BuildContext context) {
    Routemaster.of(context).push('/new-complaint');
  }

  static void navigateToNewEventScreen(BuildContext context) {
    Routemaster.of(context).push('/new-event');
  }

  static void navigateToNewNoticeScreen(BuildContext context) {
    Routemaster.of(context).push('/new-notice');
  }

  static void navigateToNewEquipmentScreen(BuildContext context) {
    Routemaster.of(context).push('/new-equipment');
  }
}
