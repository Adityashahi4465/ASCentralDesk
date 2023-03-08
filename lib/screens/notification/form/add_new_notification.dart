// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_complaint_box/screens/notification/form/form_field.dart';
import 'package:e_complaint_box/screens/notification/form/my_radio_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../global/global.dart';
import '../../../global_widgets/loding_dialog.dart';
import '../../../palatte.dart';

class AddNewNotificationScreen extends StatefulWidget {
  const AddNewNotificationScreen({Key? key}) : super(key: key);

  @override
  State<AddNewNotificationScreen> createState() =>
      _AddNewNotificationScreenState();
}

class _AddNewNotificationScreenState extends State<AddNewNotificationScreen> {
  NotificationTypeEnum? _notificationType = NotificationTypeEnum.Notification;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
  final TextEditingController desController = TextEditingController();
  final TextEditingController criteriaController = TextEditingController();
  final CollectionReference notificationDB =
      FirebaseFirestore.instance.collection('notifications');
  static const List<String> campuses = [
    'All Campuses',
    'Aryabhatt DSEU Ashok Vihar Campus',
    'Ambedkar DSEU Shakarpur Campus - I',
    'Bhai Parmanand DSEU Shakarpur Campus - II',
    'G.B. Pant DSEU Okhla-I Campus',
    'DSEU Okhla-II Campus',
    'GB Pant DSEU Okhla-III Campus',
    'Guru Nanak Dev DSEU Rohini Campus',
    'DSEU Pusa Campus',
    'DSEU Dwarka Campus',
    'DSEU Siri Fort Campus',
    'Kasturba DSEU Pitampura Campus',
    'Meerabai DSEU Maharani Bagh Campus',
    'DSEU Rajokri Campus',
    'DSEU Vivek Vihar Campus',
    'DSEU Wazirpur-I Campuss',
    'Centre for Healthcare, Allied Medical and Paramedical Sciences',
    'DSEU Dheerpur Campus',
    'DSEU Mayur Vihar Campus',
  ];
  static const List<String> prioritiesList = ['Normal', 'Medium', 'Critical'];
  static const List<String> venueList = ['Online', 'Offline', 'Hybrid'];
  String campusName = campuses[0];
  String priority = prioritiesList[0];
  String venueType = venueList[0];

  Future<void> submitForm() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
          context: context,
          builder: (c) {
            return LoadingDialogWidget(
              message:
                  'submitting new ${_notificationType == NotificationTypeEnum.Event ? "Event" : 'Notification'}\n',
            );
          });
      try {
        await notificationDB.doc().set({
          'title': titleController.text,
          'subtitle': subtitleController.text,
          'description': desController.text,
          'criteria': criteriaController.text,
          'type': _notificationType == NotificationTypeEnum.Event
              ? "Event"
              : 'Notification',
          'SubmittedBy': FirebaseAuth.instance.currentUser!.uid,
          'campus': campusName,
          'postedAt': DateTime.now(),
          'priority': priority,
          'venueType': venueType,
        });
        titleController.text = '';
        subtitleController.text = '';
        desController.text = '';
        criteriaController.text = '';

        Navigator.pop(context);
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Complaint Filed Successfully!',
        );
      } catch (e) {
        SnackBar(content: Text('Some Unknown Error Occurred $e'));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, top: 200, bottom: 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          MyRadioButton(
                              title: NotificationTypeEnum.Notification.name,
                              value: NotificationTypeEnum.Notification,
                              notificationTypeEnum: _notificationType,
                              onChanged: (val) {
                                setState(() {
                                  _notificationType = val;
                                });
                              }),
                          const SizedBox(
                            width: 5,
                          ),
                          MyRadioButton(
                              title: NotificationTypeEnum.Event.name,
                              value: NotificationTypeEnum.Event,
                              notificationTypeEnum: _notificationType,
                              onChanged: (val) {
                                setState(() {
                                  _notificationType = val;
                                });
                              }),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      FormFieldHintToolTip(
                        controller: titleController,
                        toolTipMessage:
                            'Enter the Title of ${_notificationType == NotificationTypeEnum.Event ? "Event" : 'Notification'} (Required)',
                        tipText:
                            '${_notificationType == NotificationTypeEnum.Event ? "Event" : 'Notification'} Title',
                        hintText: 'Enter The Title',
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter a Title'
                            : null,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 16.0),
                      FormFieldHintToolTip(
                        controller: subtitleController,
                        toolTipMessage: 'please enter subtitle',
                        tipText: 'Subtitle',
                        hintText: 'Enter The Subtitle',
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter a subtitle'
                            : null,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 16.0),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: const Color.fromARGB(255, 29, 17, 121),
                          ),
                          borderRadius: BorderRadius.all(campusName == null
                              ? const Radius.circular(8)
                              : const Radius.circular(2)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 11),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    campuses[0],
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black87),
                                  ),
                                  const Icon(
                                    Icons.arrow_drop_down_outlined,
                                    color: Color.fromARGB(255, 32, 36, 44),
                                  )
                                ],
                              ),
                            ),
                            value: campusName,
                            onChanged: (newValue) {
                              setState(() {
                                campusName = newValue!;
                              });
                            },
                            isExpanded: true,
                            style: kBodyText,
                            items: campuses
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 11),
                                  child: Text(
                                    value,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                            fontSize: 16,
                                            color: Colors.black87),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      FormFieldHintToolTip(
                        controller: desController,
                        toolTipMessage:
                            'please enter the message of the notification',
                        tipText: 'Description',
                        hintText: 'Enter Message',
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter a notification message'
                            : null,
                        maxLines: 5,
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Select Priority',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 4, 111, 211)),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Tooltip(
                                      message:
                                          'Please select the priority for this ${_notificationType == NotificationTypeEnum.Event ? "Event" : "Notification"}',
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(66, 178, 197, 255),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.question_mark,
                                          size: 14,
                                          color: Color.fromARGB(
                                              255, 157, 190, 248),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 29, 17, 121),
                                    ),
                                    borderRadius: BorderRadius.all(
                                        campusName == null
                                            ? const Radius.circular(8)
                                            : const Radius.circular(2)),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      hint: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 11),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              prioritiesList[0],
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black87),
                                            ),
                                            const Icon(
                                              Icons.arrow_drop_down_outlined,
                                              color: Color.fromARGB(
                                                  255, 32, 36, 44),
                                            )
                                          ],
                                        ),
                                      ),
                                      value: priority,
                                      onChanged: (newValue) {
                                        setState(() {
                                          priority = newValue!;
                                        });
                                      },
                                      isExpanded: true,
                                      style: kBodyText,
                                      items: prioritiesList
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 11),
                                            child: Text(
                                              value,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                      fontSize: 16,
                                                      color: Colors.black87),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 5),
                          _notificationType == NotificationTypeEnum.Event
                              ? Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Select Venue',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 4, 111, 211)),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Tooltip(
                                            message:
                                                'Please choose the venue for this event',
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    66, 178, 197, 255),
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                border: Border.all(
                                                  color: Colors.grey.shade600,
                                                ),
                                              ),
                                              child: const Icon(
                                                Icons.question_mark,
                                                size: 14,
                                                color: Color.fromARGB(
                                                    255, 157, 190, 248),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 29, 17, 121),
                                          ),
                                          borderRadius: BorderRadius.all(
                                              campusName == null
                                                  ? const Radius.circular(8)
                                                  : const Radius.circular(2)),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            hint: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 11),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    venueList[0],
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black87),
                                                  ),
                                                  const Icon(
                                                    Icons
                                                        .arrow_drop_down_outlined,
                                                    color: Color.fromARGB(
                                                        255, 32, 36, 44),
                                                  )
                                                ],
                                              ),
                                            ),
                                            value: venueType,
                                            onChanged: (newValue) {
                                              setState(() {
                                                venueType = newValue!;
                                              });
                                            },
                                            isExpanded: true,
                                            style: kBodyText,
                                            items: venueList
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 11),
                                                  child: Text(
                                                    value,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.black87),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      _notificationType == NotificationTypeEnum.Event
                          ? FormFieldHintToolTip(
                              controller: criteriaController,
                              toolTipMessage:
                                  'please enter minimum criteria to join this event',
                              tipText: 'Eligibility Criteria',
                              hintText: 'Enter Eligibility Criteria',
                              validator: null,
                              maxLines: 2,
                            )
                          : const SizedBox(),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: submitForm,
                        child: const Text('Send Notification'),
                      ),
                    ],
                  ),
                ),
              ),
              Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.035,
                        color: const Color(0xFF181D3D),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: (Responsive.isSmallScreen(context))
                            ? MediaQuery.of(context).size.height * 0.8
                            : MediaQuery.of(context).size.height * 0.2,
                        child: ClipPath(
                            clipper: CurveClipper(),
                            child: Container(
                              //constraints: BoxConstraints.expand(),
                              color: Color(0xFF181D3D),
                            )),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 25.0),
                      const Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/splash.png'),
                            radius: 25.0,
                            backgroundColor: Colors.transparent,
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'ASComplaints',
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white,
                              fontFamily: 'Amaranth',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: query.size.height / 25),
                      Text('Add New Notification',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontSize:
                                  (30 * MediaQuery.of(context).size.height) /
                                      1000)),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      // set the "current point"
      ..lineTo(0, size.width / 8)
      ..addArc(
          Rect.fromLTWH(0, size.width / 512 - size.width / 8, size.width / 2,
              size.width / 2),
          pi,
          -pi / 2)
      ..lineTo(4 * size.width / 4, size.width / 2 - size.width / 8)
      ..addArc(
          Rect.fromLTWH(2 * size.width / 4, size.width / 2 - size.width / 8,
              size.width / 2, size.width / 2),
          3.14 + 1.57,
          1.57)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..lineTo(0, size.width / 8);
    return path;
  }

  @override
  bool shouldReclip(oldCliper) => false;
}
