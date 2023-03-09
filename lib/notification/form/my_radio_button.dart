import 'package:flutter/material.dart';
import 'add_new_notification.dart';

enum NotificationTypeEnum { Notification, Event }

class MyRadioButton extends StatelessWidget {
  final String title;
  final NotificationTypeEnum value;
  final NotificationTypeEnum? notificationTypeEnum;
  final Function(NotificationTypeEnum?)? onChanged;
  const MyRadioButton(
      {Key? key,
      required this.title,
      required this.value,
      required this.notificationTypeEnum,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RadioListTile<NotificationTypeEnum>(
        contentPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        value: value,
        groupValue: notificationTypeEnum,
        tileColor:const Color.fromARGB(194, 194, 180, 248),
      
        dense: true,
        title: Text(title),
        onChanged: onChanged,
      ),
      
    );
  }
}
