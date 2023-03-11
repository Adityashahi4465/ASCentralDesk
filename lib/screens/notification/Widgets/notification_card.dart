import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../main_screens/notification_screen.dart';

class NotificationOverviewCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final String eligibilityCriteria;
  final String campus;
  final String priority;
  final String venueType;
  final DateTime postedAt;
  final DateTime startDate;
  final DateTime endDate;
  final String postedByUid;

  NotificationOverviewCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.eligibilityCriteria,
    required this.campus,
    required this.priority,
    required this.venueType,
    required this.postedAt,
    required this.startDate,
    required this.endDate,
    required this.postedByUid,
  });
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  String checkValidity(DateTime start, DateTime end) {
    DateTime now = DateTime.now();
    if (now.isBefore(start)) {
      return 'Upcoming';
    } else if (now.isAfter(end)) {
      return 'Expired';
    } else {
      return 'Active';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(postedByUid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const SnackBar(content: Text("Something went wrong"));
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const SnackBar(content: Text('Document does not exist'));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> user =
              snapshot.data!.data() as Map<String, dynamic>;
          return Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
            child: InkWell(
              splashColor: Colors.blue.withAlpha(300),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationDetailsScreen(
                      title: title,
                      subtitle: subtitle,
                      description: description,
                      eligibilityCriteria: eligibilityCriteria,
                      campus: campus,
                      priority: priority,
                      venueType: venueType,
                      postedAt: postedAt,
                      startDate: startDate,
                      endDate: endDate,
                      postedBy: user['email'],
                      type: 'Notification',
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Wrap(
                  children: <Widget>[
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: <Widget>[
                        const Text(
                          'Posted by ',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          user['email'],
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          ' on ',
                          style: TextStyle(fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Expanded(
                          child: Text(
                            DateFormat.yMMMMd().format(postedAt).toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.bookmark_border),
                          onPressed: () {
                            //TODO: Add color change
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      children: [
                        const Icon(
                          Icons.calendar_today,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          DateFormat.yMMMMd().format(startDate).toString(),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            subtitle,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 15),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 7),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                priority,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: priority == 'Normal'
                                      ? Colors.green
                                      : priority == 'Medium'
                                          ? Colors.yellow
                                          : priority == 'Critical'
                                              ? Colors.red
                                              : Colors.deepOrange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                'priority',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              checkValidity(startDate, endDate),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: getStatusColor(
                                    checkValidity(startDate, endDate)),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'status',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
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

        return Text("loading");
      },
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Upcoming':
        return Colors.blue;
      case 'Active':
        return Colors.green;
      case 'Expired':
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
