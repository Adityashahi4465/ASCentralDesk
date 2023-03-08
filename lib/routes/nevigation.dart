import 'package:e_complaint_box/global_widgets/loding_dialog.dart';
import 'package:e_complaint_box/widgets/drawer/students_drawer.dart';
import 'package:e_complaint_box/widgets/drawer/teachers_drawer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

var user = FirebaseAuth.instance.currentUser;

class User1 extends StatefulWidget {
  @override
  _User1State createState() => _User1State();
}

class _User1State extends State<User1> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          FirebaseFirestore.instance.collection('users').doc(user!.uid).get(),
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
            print(user.data!['type']);
            return Scaffold(
              body: (user.data!['type'] == 'admin')
                  ? const TeachersDrawer()
                  : const StudentDrawer(),
            );
        }
      },
    );
  }
}
