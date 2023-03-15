// ignore_for_file: use_build_context_synchronously

import 'package:e_complaint_box/global_widgets/loding_dialog.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils.dart';

var user = FirebaseAuth.instance.currentUser;

class Category {
  String name;
  IconData iconName;
  String text;

  Category({required this.name, required this.iconName, required this.text});
}

List<Category> categories = [
  Category(name: 'Semester', iconName: Icons.person_pin, text: 'III'),
  Category(name: 'Campus Name', iconName: Icons.location_on, text: 'Dwarka'),
];
final List<String> semesters = [
  'I',
  'II',
  'III',
  'IV',
  'V',
  'VI',
];

class CardCategory extends StatefulWidget {
  @override
  _CardCategoryState createState() => _CardCategoryState();
}

class _CardCategoryState extends State<CardCategory> {
  Future<void> editList1(BuildContext context, String semesterName) {
    return showDialog(
        context: context,
        builder: (context) {
          //    Edit Campus ******************************************************************************************************
          return EditSemester(
            semesterName: semesterName,
          );
        });
  }

  Future<void> editList2(BuildContext context, String hostelname) {
    return showDialog(
        context: context,
        builder: (context) {
          return EditCampus(campusName: hostelname);
        });
  }

  //////////////////////////       Displaying Both Cards ///////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context);

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .get()
            .asStream(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> user) {
          switch (user.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return const LoadingDialogWidget(
                message: "",
              );
            case ConnectionState.done:
              if (user.hasError) return Text('Error: ${user.error}');
              return Column(
                children: [
                  Card(
                    elevation: 5.0,
                    margin: EdgeInsets.symmetric(
                        horizontal: query.size.width / 14,
                        vertical: query.size.height / 80),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      // Displaying Semester********************************************************************************
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(categories[0].name,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontFamily: 'Roboto',
                                  )),
                              const SizedBox(height: 5.0),
                              Row(
                                children: [
                                  Icon(categories[0].iconName),
                                  const SizedBox(width: 5.0),
                                  Text(user.data!['semester'],
                                      style: GoogleFonts.quattrocento(
                                        color: Colors.white70,
                                      )),
                                ],
                              )
                            ],
                          ),
                          IconButton(
                              // calling function to edit semester
                              onPressed: () {
                                editList1(context, user.data!['semester'])
                                    .then((value) => setState(() {}));
                              },
                              icon: const Icon(Icons.edit, color: Colors.red)),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5.0,
                    margin: EdgeInsets.symmetric(
                        horizontal: query.size.width / 14,
                        vertical: query.size.height / 80),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(categories[1].name,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontFamily: 'Roboto',
                                  )),
                              const SizedBox(height: 5.0),
                              Row(
                                children: [
                                  Icon(categories[1].iconName),
                                  const SizedBox(width: 5.0),
                                  Text(user.data!['campus'],
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontFamily: 'Roboto',
                                      )),
                                ],
                              )
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                //  calling function to edit campus
                                editList2(context, user.data!['campus'])
                                    .then((value) => setState(() {}));
                              },
                              icon: const Icon(Icons.edit, color: Colors.red)),
                        ],
                      ),
                    ),
                  ),
                ],
              );
          }
        });
  }
}

class EditCampus extends StatefulWidget {
 final  String campusName;
  const EditCampus({super.key, required this.campusName});
  @override
  _EditCampusState createState() => _EditCampusState(campusName);
}

class _EditCampusState extends State<EditCampus> {
  String campusName;
  _EditCampusState(this.campusName);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Row(
          children: [
            const Text('Edit '),
            Text(categories[1].name),
          ],
        ),
        content: SingleChildScrollView(
            child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: campuses
                      .map((e) => RadioListTile(
                            title: Text(e),
                            value: e,
                            groupValue: campusName,
                            onChanged: (value) {
                              if (value != campusName) {
                                setState(() {
                                  campusName = value!;
                                });
                              }
                            },
                            selected: campusName == e,
                          ))
                      .toList(),
                ))),
        actions: <Widget>[
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            elevation: 5.0,
            child: const Text('Cancel'),
          ),
          MaterialButton(
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user?.uid)
                  .update({'campus': campusName});

              Navigator.of(context).pop();
            },
            elevation: 5.0,
            child: const Text('Save'),
          )
        ]);
  }
}

class EditSemester extends StatefulWidget {
  final String semesterName;
  const EditSemester({super.key, required this.semesterName});

  @override
  State<EditSemester> createState() => _EditSemesterState(semesterName);
}

class _EditSemesterState extends State<EditSemester> {
  String semesterName;
  _EditSemesterState(this.semesterName);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Text('Edit '),
          Text(categories[0].name),
        ],
      ),
      content: SingleChildScrollView(
          child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: semesters
                    .map((e) => RadioListTile(
                          title: Text(e),
                          value: e,
                          groupValue: semesterName,
                          onChanged: (value) {
                            if (value != semesterName) {
                              setState(() {
                                semesterName = value!;
                              });
                            }
                          },
                          selected: semesterName == e,
                        ))
                    .toList(),
              ))),
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          elevation: 5.0,
          child: const Text('Cancel'),
        ),

        ///                        update semester in database
        MaterialButton(
          onPressed: () async {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user?.uid)
                .update({'semester': semesterName});

            Navigator.of(context).pop();
          },
          elevation: 5.0,
          child: const Text('Save'),
        )
      ],
    );
  }
}
