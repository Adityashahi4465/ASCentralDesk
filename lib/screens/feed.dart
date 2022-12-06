// ignore_for_file: use_build_context_synchronously

import 'package:e_complaint_box/global/global.dart';
import 'package:e_complaint_box/screens/teacher_profile.dart';
import 'package:e_complaint_box/screens/user_profile.dart';
import 'package:flutter/material.dart';
import '../widgets/complaintDialog.dart';
import '../widgets/feedCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
ValueNotifier<Map<String, bool>> _filter =
    ValueNotifier<Map<String, bool>>(categoryComaplints);
// Sidebar Switches
bool isSwitched1 = true;
bool isSwitched2 = true;
bool isSwitched3 = true;
bool isSwitched4 = true;
bool isSwitched5 = true;
bool isSwitched6 = true;
bool isSwitched7 = true;
bool isSwitched8 = true;
bool isSwitched9 = true;
bool isSwitched10 = true;

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int selectedIndex = 0;
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      drawer: const NavDrawer(),
      body: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            children: [
              Padding(
                  padding: const EdgeInsets.only(
                      right: 20, left: 20, top: 150, bottom: 0),
                  child: ValueListenableBuilder(
                    valueListenable: _filter,
                    builder: (BuildContext context, Map<String, bool> value,
                        Widget) {
                      return Column(
                        children: [
                          Flexible(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('complaints')
                                  .orderBy('filing time', descending: true)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return const Text('Something went wrong');
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                }
                                var feedcomplaints = snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                                  if (value[document['category']] == true) {
                                    return ComplaintOverviewCard(
                                      title: document['title'],
                                      onTap: ComplaintDialog(document.id),
                                      email: document['email'],
                                      filingTime: document['filing time'],
                                      category: document['category'],
                                      description: document['description'],
                                      status: document['status'],
                                      upvotes: document['upvotes'],
                                      id: document.id,
                                    );
                                  } else {
                                    return Container(
                                      height: 0,
                                    );
                                  }
                                }).toList();
                                feedcomplaints.add(Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: const [
                                        Icon(
                                          Icons.check_circle,
                                          size: 40,
                                          color: Color(0xFF36497E),
                                        ),
                                        Text("You're All Caught Up",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54))
                                      ],
                                    )));
                                return ListView(
                                  children: feedcomplaints,
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  )),
              Padding(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, top: 150, bottom: 0),
                child: Container(
                    // add contents of the bookmark page
                    // child: Bookmarks(),
                    ),
              ),
            ],
          ),
          Stack(
            children: <Widget>[
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.035,
                    color: const Color(0xFF181D3D),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: ClipPath(
                        clipper: CurveClipper(),
                        child: Container(
                          color: const Color(0xFF181D3D),
                        )),
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(height: 25.0),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //implementation of sidebar
                      IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 30.0,
                        ),
                        onPressed: () {
                          _scaffoldState.currentState!.openDrawer();
                        },
                      ),
                      const SizedBox(
                        width: 35.0,
                      ),
                      const Text(
                        'ASComplaints',
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                          fontFamily: 'Amaranth',
                        ),
                      ),
                      const SizedBox(
                        width: 40.0,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  // Implementation of tabbar
                  Center(
                    child: SizedBox(
                      width: 300.0,
                      height: 60,
                      child: TabBar(
                        controller: _tabController,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: const BoxDecoration(
                          color: Color(0xFF606fad),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                        ),
                        tabs: [
                          Tab(
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(42.0, 0, 42.0, 0),
                              child: Column(
                                children: const [
                                  Icon(
                                    Icons.mode_comment,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  Text(
                                    'Feed',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Tab(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                              child: Column(
                                children: const [
                                  Icon(
                                    Icons.bookmark,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  Text(
                                    'Bookmarks',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

// code for the upper design of appbar

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      // set the "current point"
      ..addArc(Rect.fromLTWH(0, 0, size.width / 2, size.width / 3), pi, -1.57)
      ..lineTo(9 * size.width / 10, size.width / 3)
      ..addArc(
          Rect.fromLTWH(
              size.width / 2, size.width / 3, size.width / 2, size.width / 3),
          pi + 1.57,
          1.57)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..lineTo(0, size.width / 6);
    return path;
  }

  @override
  bool shouldReclip(oldClipper) => false;
}

Map<String, bool> categoryComaplints = {
  "Vice Chancellor": isSwitched1,
  "Dy Academic Registrar": isSwitched2,
  "Ass. Registrar": isSwitched3,
  "Campus Director": isSwitched4,
  "ASM (KK Sharma)": isSwitched5,
  "FTD Computer HOD": isSwitched6,
  "FTD Proctor SEM III (J.P Rana)": isSwitched7,
  "FTD Ass. Proctor SEM III (Prashant)": isSwitched8,
  "Subject Faculty": isSwitched9,
  "Class Representative": isSwitched10,
};

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    print(categoryComaplints);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: GestureDetector(
                onTap: () {
                  if (sharedPreferences!.getString('type') != 'admin') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => TeacherProfile()));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => const MyProfileScreen()));
                  }
                },
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8.0,
                        color: Colors.black54,
                        spreadRadius: 0.9,
                      )
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundImage: NetworkImage(
                        sharedPreferences!.get('photoUrl').toString()),
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                color: const Color(0xFF181D3D),
                child: ListTile(
                  title: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        "Hi, ${sharedPreferences!.get('name')}",
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'JosefinSans',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(2.0),
                children: [
                  ExpansionTile(
                    leading: const Icon(
                      Icons.filter_list,
                      color: Color(0xFF181D3D),
                    ),
                    title: const Text(
                      'Category',
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    children: [
                      ListTile(
                        leading: Switch(
                          value: isSwitched1,
                          onChanged: (bool value) {
                            setState(() {
                              isSwitched1 = value;
                              categoryComaplints["Vice Chancellor"] =
                                  isSwitched1;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: const Text('Vice Chancellor'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched2,
                          onChanged: (value) {
                            setState(() {
                              isSwitched2 = value;
                              categoryComaplints[
                                      "Dy Academic Registrar (Sheetu Ahuja)"] =
                                  isSwitched2;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: const Text('Dy Academic Registrar'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched3,
                          onChanged: (value) {
                            setState(() {
                              isSwitched3 = value;
                              categoryComaplints["Ass. Registrar"] =
                                  isSwitched3;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: const Text('General'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched4,
                          onChanged: (value) {
                            setState(() {
                              isSwitched4 = value;
                              categoryComaplints["Campus Director"] =
                                  isSwitched4;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: const Text('Campus Director'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched5,
                          onChanged: (value) {
                            setState(() {
                              isSwitched5 = value;
                              categoryComaplints["ASM (KK Sharma)"] =
                                  isSwitched5;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: const Text('ASM (KK Sharma)'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched6,
                          onChanged: (value) {
                            setState(() {
                              isSwitched6 = value;
                              categoryComaplints["FTD Computer HOD"] =
                                  isSwitched6;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: const Text('FTD Computer HOD'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched7,
                          onChanged: (value) {
                            setState(() {
                              isSwitched7 = value;
                              categoryComaplints[
                                      "FTD Proctor SEM III (J.P Rana)"] =
                                  isSwitched7;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: const Text('FTD Proctor SEM III (J.P Rana)'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched8,
                          onChanged: (value) {
                            setState(() {
                              isSwitched8 = value;
                              categoryComaplints[
                                      "FTD Ass. Proctor SEM III (Prashant)"] =
                                  isSwitched8;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title:
                            const Text('FTD Ass. Proctor SEM III (Prashant)'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched9,
                          onChanged: (value) {
                            setState(() {
                              isSwitched9 = value;
                              categoryComaplints["Subject Faculty"] =
                                  isSwitched9;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: const Text('Subject Faculty'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched10,
                          onChanged: (value) {
                            setState(() {
                              isSwitched10 = value;
                              categoryComaplints["Class Representative"] =
                                  isSwitched10;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: const Text('Class Representative'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              height: 0.5,
              color: Color(0xFF181D3D),
              thickness: 0.5,
              indent: 15.0,
              endIndent: 15.0,
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Color(0xFF181D3D),
              ),
              title: const Text('About'),
              onTap: () => {Navigator.pushNamed(context, '/about')},
            ),
            const Divider(
              height: 0.5,
              color: Color(0xFF181D3D),
              thickness: 0.5,
              indent: 15.0,
              endIndent: 15.0,
            ),
            ListTile(
              leading: const Icon(
                Icons.reply,
                color: Color(0xFF181D3D),
              ),
              title: const Text('Log Out'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
      ),
    );
  }
}
//
// class Bookmarks extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('users')
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> user) {
//           if (user.connectionState == ConnectionState.waiting)
//             return Center(child: CircularProgressIndicator());
//
//           final List<String> bookmarks = List<String>.from(
//               (user.data!.data() as Map<String, dynamic>)['bookmarked']);
//           print(bookmarks.runtimeType);
//           print(
//               '\n\n\n${(user.data!.data() as Map<String, dynamic>)['bookmarked']}\n');
//           return StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('complaints')
//                   .snapshots(),
//               builder: (BuildContext context,
//                   AsyncSnapshot<QuerySnapshot> snapshots) {
//                 if (snapshots.connectionState == ConnectionState.waiting)
//                   return Center(child: CircularProgressIndicator());
//
//                 List<Widget> currentBookmarks = [];
//                 snapshots.data!.docs.forEach((doc) {
//                   if (bookmarks.contains(doc.id)) {
//                     currentBookmarks.add(ComplaintOverviewCard(
//                       title: (doc.data() as Map<String, dynamic>)["title"],
//                       onTap: ComplaintDialog(doc.id),
//                       email: (doc.data() as Map<String, dynamic>)['email'],
//                       filingTime:
//                           (doc.data() as Map<String, dynamic>)['filing time'],
//                       category:
//                           (doc.data() as Map<String, dynamic>)["category"],
//                       description:
//                           (doc.data() as Map<String, dynamic>)["description"],
//                       status: (doc.data() as Map<String, dynamic>)["status"],
//                       upvotes: (doc.data() as Map<String, dynamic>)['upvotes'],
//                       id: doc.id,
//                     ));
//                   }
//                 });
//                 currentBookmarks.add(Container(
//                     padding: EdgeInsets.all(10),
//                     child: Column(
//                       children: [
//                         Icon(
//                           Icons.check_circle,
//                           size: 40,
//                           color: Color(0xFF36497E),
//                         ),
//                         Text(
//                           "You're All Caught Up",
//                           style: Theme.of(context).textTheme.headline6,
//                         )
//                       ],
//                     )));
//                 return ListView(
//                   children: currentBookmarks,
//                 );
//               });
//         });
//   }
// }
