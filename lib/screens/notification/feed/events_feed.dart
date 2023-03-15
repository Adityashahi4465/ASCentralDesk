import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_complaint_box/screens/notification/main_screens/event_screen.dart';
import 'package:flutter/material.dart';

import '../../../global_widgets/loding_dialog.dart';
import '../Widgets/event_card.dart';
import '../form/my_radio_button.dart';

class EventsFeedScreen extends StatelessWidget {
  const EventsFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('notifications')
          .orderBy('postedAt', descending: true)
          .snapshots(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: LoadingDialogWidget(
              message: 'Loading,',
            ),
          );
        }
        var feedcomplaints =
            snapshot.data!.docs.map((DocumentSnapshot document) {
          if (document['type'] == NotificationTypeEnum.Event.name) {
            return EventOverviewCard(
              title: document['title'],
              subtitle: document['subtitle'],
              description: document['description'],
              eligibilityCriteria: document['criteria'],
              campus: document['campus'],
              priority: document['priority'],
              venueType: document['venueType'],
              postedAt: document['postedAt'].toDate(),
              startDate: document['startDate'].toDate(),
              endDate: document['endDate'].toDate(),
              postedByUid: document['SubmittedBy'],
            );
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
    );
  }
}
