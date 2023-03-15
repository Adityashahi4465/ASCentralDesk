import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_complaint_box/palatte.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ComplaintOverviewCard extends StatefulWidget {
  final String title;
  final Widget onTap;
  final String email;
  final String category;
  final String description;
  final int fund;
  final String consults;
  final String status;
  final filingTime;
  final upvotes;
  final id;

  const ComplaintOverviewCard(
      {super.key,
      required this.title,
      required this.onTap,
      required this.email,
      this.filingTime,
      required this.category,
      required this.fund,
      required this.consults,
      required this.description,
      required this.status,
      this.upvotes,
      this.id});

  @override
  _ComplaintOverviewCardState createState() => _ComplaintOverviewCardState();
}

class _ComplaintOverviewCardState extends State<ComplaintOverviewCard> {
  late List upvoteArray;

  @override
  Widget build(BuildContext context) {
    upvoteArray = widget.upvotes;
    return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
        child: InkWell(
          splashColor: Colors.blue.withAlpha(300),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => widget.onTap);
          },
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
                    Expanded(
                      child: Text(
                        widget.email,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
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
                      DateFormat.yMMMMd()
                          .format(widget.filingTime.toDate())
                          .toString(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      ' in ',
                      style: TextStyle(fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.category,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold),
                    )
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
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.fund.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            'Fund Allocated',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(widget.status,
                              style: TextStyle(
                                fontSize: 16,
                                color: widget.status == 'Rejected'
                                    ? Colors.red
                                    : widget.status == 'Solved'
                                        ? Colors.green
                                        : widget.status == 'In Progress'
                                            ? Colors.blue
                                            : Colors.deepOrange,
                                fontWeight: FontWeight.bold,
                              )),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            'Status',
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
                            final complaint = await FirebaseFirestore.instance
                                .collection('complaints')
                                .doc(widget.id)
                                .get();
                            final complaintDoc = FirebaseFirestore.instance
                                .collection('complaints')
                                .doc(widget.id);

                            if (complaint.data()!['upvotes'].contains(
                                FirebaseAuth.instance.currentUser!.uid)) {
                              await complaintDoc.update({
                                'upvotes': FieldValue.arrayRemove(
                                    [FirebaseAuth.instance.currentUser!.uid])
                              });
                              setState(() {
                                upvoteArray = complaint.data()!['upvotes'];
                              });
                            } else {
                              await complaintDoc.update({
                                'upvotes': FieldValue.arrayUnion(
                                    [FirebaseAuth.instance.currentUser!.uid])
                              });
                              setState(() {
                                upvoteArray = complaint.data()!['upvotes'];
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
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
