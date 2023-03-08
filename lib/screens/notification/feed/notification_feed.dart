// ignore_for_file: use_build_context_synchronously

import 'package:e_complaint_box/global/global.dart';
import 'package:e_complaint_box/global_widgets/loding_dialog.dart';
import 'package:e_complaint_box/screens/notification/Widgets/notification_card.dart';
import 'package:e_complaint_box/screens/notification/feed/events_feed.dart';
import 'package:e_complaint_box/screens/notification/form/my_radio_button.dart';
import 'package:e_complaint_box/screens/profile/teacher_profile.dart';
import 'package:e_complaint_box/screens/profile/user_profile.dart';
import 'package:flutter/material.dart';
import '../../../widgets/dialogs/complaintDialog.dart';
import '../../../widgets/cards/feedCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
ValueNotifier<Map<String, bool>> _filter =
    ValueNotifier<Map<String, bool>>(campusesSwitch);
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
bool isSwitched11 = true;
bool isSwitched12 = true;
bool isSwitched13 = true;
bool isSwitched14 = true;
bool isSwitched15 = true;
bool isSwitched16 = true;
bool isSwitched17 = true;
bool isSwitched18 = true;

class NotificationFeedScreen extends StatefulWidget {
  const NotificationFeedScreen({super.key});

  @override
  State<NotificationFeedScreen> createState() => _NotificationFeedScreenState();
}

class _NotificationFeedScreenState extends State<NotificationFeedScreen>
    with SingleTickerProviderStateMixin {
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
          Container(
            child: TabBarView(
              controller: _tabController,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 20, left: 20, top: 150, bottom: 0),
                  child: ValueListenableBuilder(
                    valueListenable: _filter,
                    builder: (
                      BuildContext context,
                      Map<String, bool> value,
                      Widget,
                    ) {
                      return Column(
                        children: [
                          Flexible(
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('notifications')
                                  .orderBy('postedAt', descending: true)
                                  .snapshots(),
                              builder: (BuildContext context, snapshot) {
                                if (snapshot.hasError) {
                                  return const Text('Something went wrong');
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: LoadingDialogWidget(
                                      message: 'Loading,',
                                    ),
                                  );
                                }
                                var feedcomplaints = snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                                  if (document['type'] ==
                                      NotificationTypeEnum.Notification.name) {
                                    if (value[document['campus']] == true ||
                                        document['campus'] == 'All Campuses') {
                                      return  NotificationOverviewCard(
                                          title: document['title'],
                                          subtitle: document['subtitle'],
                                          description: document['description'],
                                          eligibilityCriteria:
                                              document['criteria'],
                                          campus: document['campus'],
                                          priority: document['priority'],
                                          venueType: document['venueType'],
                                          postedAt:
                                              document['postedAt'].toDate(),
                                          onTap: () {});
                                    } else {
                                      return Container(
                                        height: 0,
                                      );
                                    }
                                  } else {
                                    return Container(
                                      height: 0,
                                    );
                                  }
                                }).toList();
                                feedcomplaints.add(Container(
                                    padding: const EdgeInsets.all(10),
                                    child: const Column(
                                      children: [
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 20, left: 20, top: 150, bottom: 0),
                  child: Container(
                    // add contents of the bookmark page
                    child: const EventsFeedScreen(),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 20, left: 20, top: 150, bottom: 0),
            child: Container(
                // add contents of the bookmark page
                // child: Bookmarks(),
                ),
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
                    height: (Responsive.isSmallScreen(context))
                        ? MediaQuery.of(context).size.height * 0.8
                        : MediaQuery.of(context).size.height * 0.2,
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
                          Icons.arrow_back_sharp,
                          color: Colors.white,
                          size: 30.0,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
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
                  // //////////////////////////////////////////////Implementation of tabBar
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
                        tabs: const [
                          Tab(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.mode_comment,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  Text(
                                    'Notification',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Tab(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(42.0, 0, 42.0, 0),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.bookmark,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  Text(
                                    'Events',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.white,
                                    ),
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

Map<String, bool> campusesSwitch = {
  "Aryabhatt DSEU Ashok Vihar Campus": isSwitched1,
  "Ambedkar DSEU Shakarpur Campus - I": isSwitched2,
  "Bhai Parmanand DSEU Shakarpur Campus - II": isSwitched3,
  "G.B. Pant DSEU Okhla-I Campus": isSwitched4,
  "DSEU Okhla-II Campus": isSwitched5,
  "GB Pant DSEU Okhla-III Campus": isSwitched6,
  "Guru Nanak Dev DSEU Rohini Campus": isSwitched7,
  "DSEU Dwarka Campus": isSwitched8,
  "DSEU  Pusa Campus": isSwitched9,
  "Kasturba DSEU Pitampura Campus": isSwitched10,
  'DSEU Siri Fort Campus': isSwitched11,
  'Meerabai DSEU Maharani Bagh Campus': isSwitched12,
  'DSEU Rajokri Campus': isSwitched13,
  'DSEU Vivek Vihar Campus': isSwitched14,
  'DSEU Wazirpur-I Campuss': isSwitched15,
  'Centre for Healthcare, Allied Medical and Paramedical Sciences':
      isSwitched16,
  'DSEU Dheerpur Campus': isSwitched17,
  'DSEU Mayur Vihar Campus': isSwitched18,
};

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    print(campusesSwitch);
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
                              campusesSwitch[
                                      "Aryabhatt DSEU Ashok Vihar Campus"] =
                                  isSwitched1;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: const Text('Aryabhatt DSEU Ashok Vihar Campus'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched2,
                          onChanged: (value) {
                            setState(() {
                              isSwitched2 = value;
                              campusesSwitch[
                                      "Ambedkar DSEU Shakarpur Campus - I"] =
                                  isSwitched2;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: const Text('Ambedkar DSEU Shakarpur Campus - I'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched3,
                          onChanged: (value) {
                            setState(() {
                              isSwitched3 = value;
                              campusesSwitch[
                                      "Bhai Parmanand DSEU Shakarpur Campus - II"] =
                                  isSwitched3;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: const Text(
                            'Bhai Parmanand DSEU Shakarpur Campus - II'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched4,
                          onChanged: (value) {
                            setState(() {
                              isSwitched4 = value;
                              campusesSwitch['G.B. Pant DSEU Okhla-I Campus'] =
                                  isSwitched4;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: const Text('G.B. Pant DSEU Okhla-I Campus'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched5,
                          onChanged: (value) {
                            setState(() {
                              isSwitched5 = value;
                              campusesSwitch["DSEU Okhla-II Campus"] =
                                  isSwitched5;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: const Text('DSEU Okhla-II Campus'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched6,
                          onChanged: (value) {
                            setState(() {
                              isSwitched6 = value;
                              campusesSwitch["GB Pant DSEU Okhla-III Campus"] =
                                  isSwitched6;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: const Text('GB Pant DSEU Okhla-III Campus'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched7,
                          onChanged: (value) {
                            setState(() {
                              isSwitched7 = value;
                              campusesSwitch[
                                      "Guru Nanak Dev DSEU Rohini Campus"] =
                                  isSwitched7;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: const Text('Guru Nanak Dev DSEU Rohini Campus'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched8,
                          onChanged: (value) {
                            setState(() {
                              isSwitched8 = value;
                              campusesSwitch["DSEU Dwarka Campus"] =
                                  isSwitched8;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: const Text('DSEU Dwarka Campus'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched9,
                          onChanged: (value) {
                            setState(() {
                              isSwitched9 = value;
                              campusesSwitch['DSEU Pusa Campus'] = isSwitched9;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: const Text('DSEU Pusa Campus'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched10,
                          onChanged: (value) {
                            setState(() {
                              isSwitched10 = value;
                              campusesSwitch["Kasturba DSEU Pitampura Campus"] =
                                  isSwitched10;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: const Text('Kasturba DSEU Pitampura Campus'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched11,
                          onChanged: (value) {
                            setState(() {
                              isSwitched11 = value;
                              campusesSwitch["DSEU Siri Fort Campus"] =
                                  isSwitched11;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: const Text("DSEU Siri Fort Campus"),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched12,
                          onChanged: (value) {
                            setState(() {
                              isSwitched12 = value;
                              campusesSwitch[
                                      "Meerabai DSEU Maharani Bagh Campus"] =
                                  isSwitched12;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: const Text('Meerabai DSEU Maharani Bagh Campus'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched13,
                          onChanged: (value) {
                            setState(() {
                              isSwitched13 = value;
                              campusesSwitch["DSEU Rajokri Campus"] =
                                  isSwitched13;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: const Text('DSEU Rajokri Campus'),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched14,
                          onChanged: (value) {
                            setState(() {
                              isSwitched14 = value;
                              campusesSwitch['DSEU Vivek Vihar Campus'] =
                                  isSwitched14;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: const Text(
                          'DSEU Vivek Vihar Campus',
                        ),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched15,
                          onChanged: (value) {
                            setState(() {
                              isSwitched15 = value;
                              campusesSwitch['DSEU Wazirpur-I Campuss'] =
                                  isSwitched15;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: const Text(
                          'DSEU Wazirpur-I Campuss',
                        ),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched16,
                          onChanged: (value) {
                            setState(() {
                              isSwitched16 = value;
                              campusesSwitch[
                                      'Centre for Healthcare, Allied Medical and Paramedical Sciences'] =
                                  isSwitched16;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: const Text(
                          'Centre for Healthcare, Allied Medical and Paramedical Sciences',
                        ),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched17,
                          onChanged: (value) {
                            setState(() {
                              isSwitched17 = value;
                              campusesSwitch['DSEU Dheerpur Campus'] =
                                  isSwitched17;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: const Text(
                          'DSEU Dheerpur Campus',
                        ),
                      ),
                      ListTile(
                        leading: Switch(
                          value: isSwitched18,
                          onChanged: (value) {
                            setState(() {
                              isSwitched18 = value;
                              campusesSwitch['DSEU Mayur Vihar Campus'] =
                                  isSwitched17;
                              _filter.notifyListeners();
                            });
                          },
                          activeTrackColor: Colors.grey[800],
                          activeColor: Colors.white,
                        ),
                        title: const Text(
                          'DSEU Mayur Vihar Campus',
                        ),
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
