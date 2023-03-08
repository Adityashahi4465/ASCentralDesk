import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_complaint_box/global_widgets/loding_dialog.dart';
import 'package:e_complaint_box/screens/Complaint/feed/student/students_Filed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../global/global.dart';
import '../../widgets/cards/card.dart';
import '../Complaint/feed/student/students_Resolved.dart';

var st = FirebaseAuth.instance.currentUser;
GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

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
  bool shouldReclip(oldClipper) => false;
}

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context);
    return Scaffold(
      body: FutureBuilder(
          future:
              FirebaseFirestore.instance.collection('users').doc(st!.uid).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> user) {
            switch (user.connectionState) {
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting:
                return const LoadingDialogWidget(message: "");
              case ConnectionState.done:
                if (user.hasError) return Text('Error: ${user.error}');
                List<String> ls =
                    List.from(user.data!['list of my filed Complaints']);
                List<String> resList = [];

                for (var i = 0; i < ls.length; i++) {
                  FirebaseFirestore.instance
                      .collection('Complaints')
                      .where('status', isEqualTo: 'Solved')
                      .where('uid', isEqualTo: st!.uid)
                      .limit(1)
                      .get()
                      .then((value) =>
                          resList.add(FieldPath.documentId.toString()));
                }
                print(resList);
                return Container(
                  color: const Color(0xFF181D3D),
                  child: SafeArea(
                    child: Scaffold(
                      key: _scaffoldState,
                      body: ListView(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: (Responsive.isSmallScreen(context))
                                ? MediaQuery.of(context).size.height / 4
                                : MediaQuery.of(context).size.height * 0.2,
                            child: ClipPath(
                                clipper: CurveClipper(),
                                child: Container(
                                  constraints: const BoxConstraints.expand(),
                                  color: const Color(0xFF181D3D),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 25.0),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              if (ZoomDrawer.of(context)!
                                                  .isOpen()) {
                                                ZoomDrawer.of(context)!.close();
                                              } else {
                                                ZoomDrawer.of(context)!.open();
                                              }
                                            },
                                            icon: const Icon(Icons.menu,
                                                color: Colors.white),
                                          ),
                                          const CircleAvatar(
                                            backgroundImage: AssetImage(
                                                'assets/images/splash.png'),
                                            radius: 25.0,
                                            backgroundColor: Colors.transparent,
                                          ),
                                          const SizedBox(
                                            width: 35.0,
                                          ),
                                          const Text(
                                            'ASComplaint',
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
                                              fontSize: Responsive
                                                      .isSmallScreen(context)
                                                  ? (30 *
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height) /
                                                      1000
                                                  : (30 *
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height) /
                                                      100)),
                                    ],
                                  ),
                                )),
                          ),
                          SizedBox(height: query.size.height / 50),
                          Center(
                            child: Text(
                              //'${FirebaseAuth.instance.currentUser.displayName}',
                              user.data!['name'],
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Roboto',
                                fontSize: Responsive.isSmallScreen(context)
                                    ? 20.0
                                    : 40,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          SizedBox(
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('complaints')
                                    .where('status', isEqualTo: 'Solved')
                                    .where('uid', isEqualTo: st!.uid)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Text('',
                                        style: TextStyle(
                                          fontSize: 25.0,
                                          color: Colors.grey[800],
                                          fontFamily: 'Roboto',
                                        ));
                                  }
                                  return Row(children: [
                                    Expanded(
                                      flex: 3,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (builder) =>
                                                        const Filed()));
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.grey,
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                color: Colors.grey,
                                                width: 1.0,
                                                style: BorderStyle.solid,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(0.0),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              child: Column(
                                                children: [
                                                  Text(
                                                      (ls.length -
                                                              snapshot.data!
                                                                  .docs.length)
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 25.0,
                                                        color: Colors.grey[800],
                                                        fontFamily: 'Roboto',
                                                      )),
                                                  const SizedBox(height: 5.0),
                                                  Text('Complaints Filed',
                                                      style: TextStyle(
                                                        color: Colors.grey[800],
                                                        fontFamily: 'Roboto',
                                                        fontSize: 3 *
                                                            query.size.width /
                                                            100,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          )),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (builder) =>
                                                      const Resolved()));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blueGrey[50],
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                              color: Colors.grey,
                                              width: 1.0,
                                              style: BorderStyle.solid,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            child: Column(
                                              children: [
                                                Text(
                                                    snapshot.data!.docs.length
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 25.0,
                                                      color: Colors.grey[800],
                                                      fontFamily: 'Roboto',
                                                    )),
                                                const SizedBox(height: 5.0),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0),
                                                  child: Text(
                                                      'Complaints Resolved',
                                                      style: TextStyle(
                                                        color: Colors.grey[800],
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
                                  ]);
                                }),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Category',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontFamily: 'Roboto',
                                      )),
                                  const SizedBox(height: 5.0),
                                  Row(
                                    children: [
                                      const Icon(Icons.person),
                                      const SizedBox(width: 5.0),
                                      Text(user.data!['type'],
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontFamily: 'Roboto',
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          CardCategory(),
                        ],
                      ),
                    ),
                  ),
                );
            }
          }),
    );
  }
}

/* return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              if (ZoomDrawer.of(context)!.isOpen()) {
                ZoomDrawer.of(context)!.close();
              } else {
                ZoomDrawer.of(context)!.open();
              }
            },
            icon: const Icon(Icons.menu, color: Colors.white),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.white54,
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(2, 0.0),
                stops: [0.1, 1.0],
                tileMode: TileMode.mirror,
              ),
            ),
          ),
          title: const Text(
            "DashBoard",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
      body: CustomScrollView(
        slivers: [
          //image slider
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .3,
                width: MediaQuery.of(context).size.width,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * .9,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 2),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: itemsImagesList.map((index) {
                    return Builder(builder: (BuildContext c) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 1.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.asset(
                            index,
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    });
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );*/
