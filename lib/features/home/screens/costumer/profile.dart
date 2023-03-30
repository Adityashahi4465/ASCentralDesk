// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:harvestx/core/constants/firebase_constents.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../core/common/alert_dialog.dart';
import '../../../../core/common/background.dart';

class ProfileScreen extends StatefulWidget {
  final String documentId;
  const ProfileScreen({
    required this.documentId,
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CollectionReference users =
      FirebaseFirestore.instance.collection(FirebaseConstants.usersCollection);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Some error Occurred');
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            backgroundColor: Colors.grey.shade300,
            body: Stack(
              children: [
                Container(
                  height: 230,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        HexColor('#00FF77'),
                        HexColor('#053D00'),
                      ],
                    ),
                  ),
                ),
                CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      centerTitle: true,
                      pinned: true,
                      elevation: 0,
                      backgroundColor: Colors.white,
                      expandedHeight: 140,
                      flexibleSpace: LayoutBuilder(
                        builder: (context, constraints) {
                          return FlexibleSpaceBar(
                            title: AnimatedOpacity(
                              duration: const Duration(milliseconds: 200),
                              opacity:
                                  constraints.biggest.height <= 120 ? 1 : 0,
                              child: const Text(
                                'My Profile',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            background: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    HexColor('#00FF77'),
                                    HexColor('#053D00'),
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 25, left: 30),
                                child: Row(
                                  children: [
                                    data['profileImage'] == ''
                                        ? const CircleAvatar(
                                            radius: 50,
                                            backgroundImage: AssetImage(
                                              'images/inapp/guest.jpg',
                                            ),
                                          )
                                        : CircleAvatar(
                                            radius: 50,
                                            backgroundImage: NetworkImage(
                                                data['profileImage']),
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 25),
                                      child: Text(
                                        data['name'].toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromARGB(
                                              255, 239, 240, 255),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(193, 9, 7, 142),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      bottomLeft: Radius.circular(30),
                                    ),
                                  ),
                                  child: TextButton(
                                      onPressed: () => Navigator.pushNamed(
                                            context,
                                            '/cart_screen',
                                          ),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        height: 45,
                                        child: const Center(
                                          child: Text(
                                            'Cart',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 33, 225, 71),
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      )),
                                ),
                                Container(
                                  color: const Color.fromARGB(255, 28, 211, 59),
                                  child: TextButton(
                                      onPressed: () => Navigator.pushNamed(
                                          context, '/customer_orders'),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        height: 40,
                                        child: const Center(
                                          child: Text(
                                            'Orders',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 241, 244, 255),
                                                fontSize: 18),
                                          ),
                                        ),
                                      )),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(193, 9, 7, 142),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      bottomRight: Radius.circular(30),
                                    ),
                                  ),
                                  child: TextButton(
                                      onPressed: () => Navigator.pushNamed(
                                          context, '/wishlist_screen'),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        height: 40,
                                        child: const Center(
                                          child: Text(
                                            'WishList',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 33, 225, 71),
                                                fontSize: 18),
                                          ),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            children: [
                              BackgroundImage(
                                color: const Color.fromARGB(173, 233, 234, 250),
                              ),
                              Column(
                                children: [
                                  const ProfileHeaderLabel(
                                    headerLabel: '  Account Info.  ',
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: 260,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            225, 206, 244, 202),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Column(
                                        children: [
                                          RepeatedListTile(
                                            title: 'Email Address',
                                            subTitle: data['email'] == ''
                                                ? 'example@gmail.com'
                                                : data['email'],
                                            icon: Icons.email,
                                            onPressed: () {},
                                          ),
                                          const YellowDivider(),
                                          RepeatedListTile(
                                              title: 'Phone',
                                              subTitle: data['phone'] == ''
                                                  ? 'example : +91123456789 '
                                                  : 'Phone No.',
                                              icon: Icons.phone,
                                              onPressed: () {}),
                                          const YellowDivider(),
                                          RepeatedListTile(
                                            title: 'Address',
                                            subTitle: data['address'] == ''
                                                ? 'example :Karol Bagh ,Delhi'
                                                : data['address'],
                                            icon: Icons.location_pin,
                                            onPressed: () {},
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const ProfileHeaderLabel(
                                      headerLabel: '  Account Settings  '),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: 260,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            225, 206, 244, 202),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Column(
                                        children: [
                                          RepeatedListTile(
                                            title: 'Edit Profile',
                                            subTitle: '',
                                            icon: Icons.edit,
                                            onPressed: () {},
                                          ),
                                          const YellowDivider(),
                                          RepeatedListTile(
                                            title: 'Change Password',
                                            subTitle: '',
                                            icon: Icons.lock,
                                            onPressed: () {},
                                          ),
                                          const YellowDivider(),
                                          RepeatedListTile(
                                            title: 'Log Out',
                                            subTitle: '',
                                            icon: Icons.logout,
                                            onPressed: () async {
                                              MyAlertDialog.showMyDialog(
                                                context: context,
                                                title: 'Log Out',
                                                content:
                                                    'Are you sure to log out ?',
                                                tabNo: () =>
                                                    Navigator.pop(context),
                                                tabYes: () async {
                                                  await FirebaseAuth.instance
                                                      .signOut();
                                                  Navigator.pop(context);
                                                  Navigator
                                                      .pushReplacementNamed(
                                                          context,
                                                          '/welcome_screen');
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(
            color: Colors.yellow,
          ),
        );
      },
    );
  }
}

class YellowDivider extends StatelessWidget {
  const YellowDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: Divider(
        color: Color.fromARGB(103, 166, 161, 252),
        thickness: 1,
      ),
    );
  }
}

class RepeatedListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final Function()? onPressed;

  const RepeatedListTile({
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ListTile(
        title: Text(
          title,
        ),
        subtitle: Text(subTitle),
        leading: Icon(icon),
      ),
    );
  }
}

class ProfileHeaderLabel extends StatelessWidget {
  final String headerLabel;
  const ProfileHeaderLabel({
    required this.headerLabel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          Text(
            headerLabel,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
