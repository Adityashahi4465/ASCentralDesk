// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_complaint_box/models/complaints_class.dart';
import 'package:e_complaint_box/screens/notification/main_screens/event_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../global_widgets/loding_dialog.dart';

class EventOverviewCard extends StatelessWidget {
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

  EventOverviewCard({
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11)),
              child: InkWell(
                splashColor: Colors.blue.withAlpha(300),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EventDetailsScreen(
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
                            )),
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
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Row(
                        children: <Widget>[
                          Text(
                            'Posted by ',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12),
                          ),
                          // Expanded(
                          //   child: Text(
                          //     widget.email,
                          //     overflow: TextOverflow.ellipsis,
                          //     style: const TextStyle(
                          //         fontSize: 12, fontWeight: FontWeight.bold),
                          //   ),
                          // ),
                          /*IconButton(
                            icon: Icon(Icons
                                .bookmark_border),
                            onPressed: () {
                              //TODO: Add color change
                        })*/
                        ],
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.end,
                        children: [
                          const Icon(Icons.calendar_today),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            DateFormat.yMMMMd().format(startDate).toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        
                          // Text(
                          //   widget.category,
                          //   overflow: TextOverflow.ellipsis,
                          //   style: const TextStyle(
                          //       fontSize: 13, fontWeight: FontWeight.bold),
                          // )
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              description,
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
                              children: <Widget>[
                                Text(checkValidity(startDate, endDate),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: getStatusColor(
                                          checkValidity(startDate, endDate)),
                                      fontWeight: FontWeight.bold,
                                    )),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Text(
                                  'status',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          /*Column(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.arrow_upward,
                                color: (upvoteArray.contains(
                                        FirebaseAuth.instance.currentUser!.uid))
                                    ? Colors.blue[400]
                                    : Colors.black,
                              ),
                              onPressed: () async {
                                final Notification = await FirebaseFirestore.instance
                                    .collection('complaints')
                                    .doc(widget.id)
                                    .get();
                                final NotificationDoc = FirebaseFirestore.instance
                                    .collection('complaints')
                                    .doc(widget.id);
    
                                if (complaint.data()!['upvotes'].contains(
                                    FirebaseAuth.instance.currentUser!.uid)) {
                                  await NotificationDoc.update({
                                    'upvotes': FieldValue.arrayRemove(
                                        [FirebaseAuth.instance.currentUser!.uid])
                                  });
                                  setState(() {
                                    upvoteArray = Notification.data()!['upvotes'];
                                  });
                                } else {
                                  await NotificationDoc.update({
                                    'upvotes': FieldValue.arrayUnion(
                                        [FirebaseAuth.instance.currentUser!.uid])
                                  });
                                  setState(() {
                                    upvoteArray = Notification.data()!['upvotes'];
                                  });
                                }
                              },
                            ),
                            Text(
                              upvoteArray.length == 1
                                  ? '1 Upvote'
                                  : '${upvoteArray.length.toString()} Upvotes',
                              style: const TextStyle(
                                fontSize: 13,
                              ),
                            )
                          ],
                        ) */
                        ],
                      )
                    ],
                  ),
                ),
              ));
        }
        return const LoadingDialogWidget(
          message: 'Loading Data',
        );
      },
    );
  }
}
