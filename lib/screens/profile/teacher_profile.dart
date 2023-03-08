import 'package:e_complaint_box/global_widgets/loding_dialog.dart';
import 'package:e_complaint_box/screens/Complaint/feed/admin/admin_pendin_complaints.dart';
import 'package:e_complaint_box/screens/Complaint/feed/admin/admin_resolved_complaints.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

import '../../global/global.dart';

var user = FirebaseAuth.instance.currentUser;

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

Map<String, String> departments = {
  'Vice Chancellor': 'aditya.png',
  'General': 'general.jpg',
  'image': 'hostel.jpg',
  'Campus': 'parliament.jpg',
  'Proctor': 'proctor.jpg'
};
GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class TeacherProfile extends StatefulWidget {
  @override
  _TeacherProfileState createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context);
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
              List<String> ls =
                  List.from(user.data!['list of my filed Complaints']);

              return Scaffold(
                key: _scaffoldState,
                body: Stack(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                          padding: const EdgeInsets.only(
                              right: 0, left: 0, top: 150, bottom: 0),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ListView(children: [
                                SizedBox(height: query.size.height / 32),
                                Center(
                                  child: Container(
                                    width: query.size.width / 2.5,
                                    height: query.size.width / 2.5,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/${(departments.containsKey(user.data!["category"])) ? departments[user.data!["category"]] : departments['image']}'),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                SizedBox(height: query.size.height / 50),
                                Center(
                                  child: Text(
                                    //'${FirebaseAuth.instance.currentUser.displayName}',
                                    user.data!['category'],
                                    style: const TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 20.0,
                                        color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                SizedBox(
                                  child: Row(children: [
                                    Expanded(
                                      flex: 3,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (builder) =>
                                                      const AdminPending()));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            child: Column(
                                              children: [
                                                StreamBuilder(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            'complaints')
                                                        .where('status',
                                                            whereIn: [
                                                              'Pending',
                                                              'In Progress'
                                                            ])
                                                        .where('category',
                                                            isEqualTo:
                                                                user.data![
                                                                    'category'])
                                                        .snapshots(),
                                                    builder: (BuildContext
                                                            context,
                                                        AsyncSnapshot<
                                                                QuerySnapshot>
                                                            passed) {
                                                      if (passed
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return Text('',
                                                            style: TextStyle(
                                                              fontSize: 25.0,
                                                              color: Colors
                                                                  .grey[800],
                                                              fontFamily:
                                                                  'Roboto',
                                                            ));
                                                      }
                                                      return Text(
                                                          passed
                                                              .data!.docs.length
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 25.0,
                                                            color:
                                                                Colors.white70,
                                                            fontFamily:
                                                                'Roboto',
                                                          ));
                                                    }),
                                                const SizedBox(height: 5.0),
                                                Text('Complaints Pending',
                                                    style: TextStyle(
                                                      color: Colors.white54,
                                                      fontFamily: 'Roboto',
                                                      fontSize: 3 *
                                                          query.size.width /
                                                          100,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (builder) =>
                                                      const AdminResolved()));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            child: Column(
                                              children: [
                                                StreamBuilder(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            'complaints')
                                                        .where('status',
                                                            isEqualTo: 'Solved')
                                                        .where('category',
                                                            isEqualTo:
                                                                user.data![
                                                                    'category'])
                                                        .snapshots(),
                                                    builder: (BuildContext
                                                            context,
                                                        AsyncSnapshot<
                                                                QuerySnapshot>
                                                            resolved) {
                                                      if (resolved
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return Text('',
                                                            style: TextStyle(
                                                              fontSize: 25.0,
                                                              color: Colors
                                                                  .grey[800],
                                                              fontFamily:
                                                                  'Roboto',
                                                            ));
                                                      }
                                                      print(resolved.data);
                                                      return Text(
                                                          resolved
                                                              .data!.docs.length
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 25.0,
                                                            color:
                                                                Colors.white70,
                                                            fontFamily:
                                                                'Roboto',
                                                          ));
                                                    }),
                                                const SizedBox(height: 5.0),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0),
                                                  child: Text(
                                                      'Complaints Resolved',
                                                      style: TextStyle(
                                                        color: Colors.white54,
                                                        fontFamily: 'Roboto',
                                                        fontSize: 3 *
                                                            query.size.width /
                                                            100,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ]),
                                ),
                                const SizedBox(height: 15.0),
                                Card(
                                    elevation: 5.0,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: query.size.width / 14,
                                        vertical: query.size.height / 80),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Category',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontFamily: 'Roboto',
                                              )),
                                          const SizedBox(height: 5.0),
                                          Row(
                                            children: const [
                                              Icon(Icons.person),
                                              SizedBox(width: 5.0),
                                              Text('Admin',
                                                  style: TextStyle(
                                                    color: Colors.white70,
                                                    fontFamily: 'Roboto',
                                                  )),
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                                Card(
                                    elevation: 5.0,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: query.size.width / 14,
                                        vertical: query.size.height / 80),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('E-Mail',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontFamily: 'Roboto',
                                              )),
                                          const SizedBox(height: 5.0),
                                          Row(
                                            children: [
                                              const Icon(Icons.person),
                                              const SizedBox(width: 5.0),
                                              Text(user.data!['email'],
                                                  style: const TextStyle(
                                                    color: Colors.white70,
                                                    fontFamily: 'Roboto',
                                                  )),
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                              ]))),
                    ),
                    Stack(
                      children: <Widget>[
                        Column(
                          children: [
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.035,
                              color: Color(0xFF181D3D),
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
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 25.0),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/images/splash.png'),
                                    radius: 25.0,
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
                              Text('Profile',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Roboto',
                                      fontSize: (30 *
                                              MediaQuery.of(context)
                                                  .size
                                                  .height) /
                                          1000)),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
          }
        });
  }
}
