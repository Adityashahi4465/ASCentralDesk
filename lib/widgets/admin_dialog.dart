import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_complaint_box/global_widgets/loding_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../models/ComplaintFile.dart';
import '../models/complaints_class.dart';

class AdminDialog extends StatefulWidget {
  final String _complaintID;
  const AdminDialog(this._complaintID, {super.key});
  @override
  _AdminDialogState createState() => _AdminDialogState();
}

class _AdminDialogState extends State<AdminDialog> {
  @override
  Widget build(BuildContext context) {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');

    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('complaints')
            .doc(widget._complaintID)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Dialog(
                // insetAnimationCurve: Curves.bounceIn,
                // insetPadding: const EdgeInsets.all(50),
                // insetAnimationDuration: const Duration(seconds: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5.0,
                backgroundColor: Colors.transparent,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            snapshot.data!['title'],
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: 20.0,
                                color: Color(0xFF181D3D),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        const Text(
                          'posted by ',
                          style: TextStyle(fontSize: 12.0),
                        ),
                        Text(
                          snapshot.data!['email'],
                          style: const TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color.fromRGBO(53, 99, 184, 1),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              '${DateFormat('kk:mm:a').format(snapshot.data!['filing time'].toDate())}\n${DateFormat('dd-MM-yyyy').format(snapshot.data!['filing time'].toDate())}',
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.blueGrey,
                                height: 1.0,
                              ),
                            ),
                            const Spacer(),
                            Text(snapshot.data!['category'],
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  height: 1.0,
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(snapshot.data!['description']),
                        const SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          height: snapshot.data!['list of Images'].length != 0
                              ? (3.8 * MediaQuery.of(context).size.height) / 10
                              : 0, // card height
                          child: PageView(
                              scrollDirection: Axis.horizontal,
                              controller: PageController(viewportFraction: 1),
                              //pageSnapping: ,
                              children: snapshot.data!['list of Images']
                                  .map<Widget>((imag) => Card(
                                        elevation: 6.0,
                                        margin: const EdgeInsets.all(10.0),
                                        child: Image.network(
                                          imag,
                                        ),
                                      ))
                                  .toList()),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              'Status:',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF181D3D),
                                fontSize: 12.0,
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              snapshot.data!['status'],
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.yellow[900]),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              onTap: () => Fluttertoast.showToast(
                                  msg: "Double Tap to Reject the complaint"),
                              onDoubleTap: () async {
                                if (snapshot.data!['status'] != status[3]) {
                                  await ComplaintFiling()
                                      .complaints
                                      .doc(widget._complaintID)
                                      .update({'status': status[2]});
                                }
                              },
                              child: Container(
                                //color: Color(0xFF181D3D),
                                width:
                                    (0.7 * MediaQuery.of(context).size.width -
                                            30) /
                                        3,
                                height:
                                    (0.6 * MediaQuery.of(context).size.height) /
                                        10,
                                decoration: BoxDecoration(
                                  color: Colors.deepOrange,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular((0.6 *
                                              MediaQuery.of(context)
                                                  .size
                                                  .height) /
                                          20),
                                      bottomLeft: Radius.circular((0.6 *
                                              MediaQuery.of(context)
                                                  .size
                                                  .height) /
                                          20),
                                      topRight: Radius.zero,
                                      bottomRight: Radius.zero),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Reject",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            const VerticalDivider(
                              color: Color.fromRGBO(58, 128, 203, 1),
                              width: 1.0,
                            ),
                            InkWell(
                              onTap: () => Fluttertoast.showToast(
                                  msg: "Double Tap to Approve the complaint"),
                              onDoubleTap: () async {
                                if (snapshot.data!['status'] != status[2]) {
                                  await ComplaintFiling()
                                      .complaints
                                      .doc(widget._complaintID)
                                      .update({'status': status[1]});
                                }
                              },
                              child: Container(
                                //color: Color(0xFF181D3D),
                                width:
                                    (0.7 * MediaQuery.of(context).size.width -
                                            30) /
                                        3,
                                height:
                                    (0.6 * MediaQuery.of(context).size.height) /
                                        10,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF181D3D),
                                  shape: BoxShape.rectangle,
                                ),
                                child: const Center(
                                  child: Text(
                                    "Approve",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            const VerticalDivider(
                              color: Color.fromRGBO(58, 128, 203, 1),
                              width: 1.0,
                            ),
                            InkWell(
                              onTap: () => Fluttertoast.showToast(
                                  msg:
                                      "Double Tap to mark it as Solved the Complaint"),
                              onDoubleTap: () async {
                                if (snapshot.data!['status'] != status[2]) {
                                  //await snapshot.data.data().update('status', (value) => status[4]);
                                  await ComplaintFiling()
                                      .complaints
                                      .doc(widget._complaintID)
                                      .update({'status': status[3]});
                                }
                              },
                              child: Container(
                                //color: Color(0xFF181D3D),
                                width:
                                    (0.7 * MediaQuery.of(context).size.width -
                                            30) /
                                        3,
                                height:
                                    (0.6 * MediaQuery.of(context).size.height) /
                                        10,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.zero,
                                      bottomLeft: Radius.zero,
                                      topRight: Radius.circular((0.6 *
                                              MediaQuery.of(context)
                                                  .size
                                                  .height) /
                                          20),
                                      bottomRight: Radius.circular((0.6 *
                                              MediaQuery.of(context)
                                                  .size
                                                  .height) /
                                          20)),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Solved",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )));
          } else {
            return const LoadingDialogWidget();
          }
        });
  }
}
