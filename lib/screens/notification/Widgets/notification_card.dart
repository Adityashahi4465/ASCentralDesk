import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationOverviewCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String description;
  final String eligibilityCriteria;
  final String campus;
  final String priority;
  final String venueType;
  final DateTime postedAt;
  final Function() onTap;

  const NotificationOverviewCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.eligibilityCriteria,
    required this.campus,
    required this.priority,
    required this.venueType,
    required this.postedAt,
    required this.onTap,
  });

  @override
  State<NotificationOverviewCard> createState() =>
      _NotificationOverviewCardState();
}

class _NotificationOverviewCardState extends State<NotificationOverviewCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
        child: InkWell(
          splashColor: Colors.blue.withAlpha(300),
          onTap: widget.onTap,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Wrap(
              children: <Widget>[
                Text(
                  widget.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: <Widget>[
                    const Text(
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
                      DateFormat.yMMMMd().format(widget.postedAt).toString(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      ' in ',
                      style: TextStyle(fontSize: 13),
                      overflow: TextOverflow.ellipsis,
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
                        widget.description,
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
                          Text(widget.priority,
                              style: TextStyle(
                                fontSize: 16,
                                color: widget.priority == 'Rejected'
                                    ? Colors.red
                                    : widget.priority == 'Solved'
                                        ? Colors.green
                                        : widget.priority == 'In Progress'
                                            ? Colors.blue
                                            : Colors.deepOrange,
                                fontWeight: FontWeight.bold,
                              )),
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
}
