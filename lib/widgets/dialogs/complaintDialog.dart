import 'package:e_complaint_box/global_widgets/loding_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ComplaintDialog extends StatefulWidget {
  final String _complaintID;
  const ComplaintDialog(this._complaintID);
  @override
  _ComplaintDialogState createState() => _ComplaintDialogState();
}

class _ComplaintDialogState extends State<ComplaintDialog> {
  final CollectionReference _complaints =
      FirebaseFirestore.instance.collection('complaints');
  final DocumentReference _userDocument = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  bool bookmarked = false;

  @override
  @override
  Widget build(BuildContext context) {
    //_userDocument.get().then((value) {bookmarked=value.data()['bookmarked'].contains(widget._complaintID);});
    return FutureBuilder<DocumentSnapshot>(
        future: _userDocument.get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> aot) {
          return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('complaints')
                  .doc(widget._complaintID)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 500,
                    ),
                    child: Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5.0,
                        backgroundColor: Colors.transparent,
                        child: SingleChildScrollView(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            padding: const EdgeInsets.all(15.0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.topCenter,
                                              child: Text(
                                                (snapshot.data!.data() as Map<
                                                    String, dynamic>)['title'],
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 20.0,
                                                    color: Color(0xFF181D3D),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 6.0,
                                            ),
                                            const Text(
                                              'posted by:',
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.black87),
                                            ),
                                            Text(
                                              (snapshot.data!.data() as Map<
                                                  String, dynamic>)['email'],
                                              style: const TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: Color.fromRGBO(
                                                      53, 99, 184, 1),
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //new Spacer(),
                                      // ////////////////////////////////////////////////////////////////BOOKMARKS??????????????????????????????????????????????????????????
                                      //    IconButton(
                                      //      onPressed: () async {
                                      //        if (await _userDocument.get().then(
                                      //            (value) => (value.data() as Map<
                                      //                    String,
                                      //                    dynamic>)['bookmarked']
                                      //                .contains(
                                      //                    widget._complaintID))) {
                                      //          await _userDocument.update({
                                      //            'bookmarked':
                                      //                FieldValue.arrayRemove(
                                      //                    [widget._complaintID])
                                      //          });
                                      //          setState(() {
                                      //            bookmarked = false;
                                      //          });
                                      //        } else {
                                      //          await _userDocument.update({
                                      //            'bookmarked': FieldValue.arrayUnion(
                                      //                [widget._complaintID])
                                      //          });
                                      //          setState(() {
                                      //            bookmarked = true;
                                      //          });
                                      //        }
                                      //      },
                                      //      icon: Icon(
                                      //        bookmarked
                                      //            ? Icons.bookmark
                                      //            : Icons.bookmark_border,
                                      //        color: Colors.purple,
                                      //      ),
                                      //    ////////////////////////////////////////////////////////////////BOOKMARKS??????????????????????????????????????????????????????????    )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        '${DateFormat('kk:mm:a').format((snapshot.data!.data() as Map<String, dynamic>)['filing time'].toDate())}\n${DateFormat('dd-MM-yyyy').format((snapshot.data!.data() as Map<String, dynamic>)['filing time'].toDate())}',
                                        style: const TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54),
                                      ),
                                      const Spacer(),
                                      Text(
                                          ((snapshot.data!.data() as Map<String,
                                              dynamic>)['category']),
                                          style: const TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black54))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    (snapshot.data!.data()
                                        as Map<String, dynamic>)['description'],
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Color.fromARGB(255, 53, 53, 53),
                                        fontFamily: 'Amaranth'),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  SizedBox(
                                    height: (snapshot.data!.data() as Map<
                                                    String,
                                                    dynamic>)['list of Images']
                                                .length !=
                                            0
                                        ? (3.8 *
                                                MediaQuery.of(context)
                                                    .size
                                                    .height) /
                                            10
                                        : 0, // card height
                                    child: PageView(
                                        scrollDirection: Axis.horizontal,
                                        controller:
                                            PageController(viewportFraction: 1),
                                        //pageSnapping: ,
                                        children: (snapshot.data!.data() as Map<
                                                String,
                                                dynamic>)['list of Images']
                                            .map<Widget>((imag) => Card(
                                                  elevation: 6.0,
                                                  margin: const EdgeInsets.all(
                                                      10.0),
                                                  child: Image.network(
                                                    imag,
                                                  ),
                                                ))
                                            .toList()),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Consults:',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black87),
                                      ),
                                      Expanded(
                                        child: Text(
                                          (snapshot.data!.data() as Map<String,
                                              dynamic>)['consults'],
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.pinkAccent,
                                            fontFamily: 'Amaranth',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        height: (0.8 *
                                                MediaQuery.of(context)
                                                    .size
                                                    .height) /
                                            10,
                                        width: (1.05 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                30) /
                                            3,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF181D3D),
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
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              (snapshot.data!.data() as Map<
                                                  String, dynamic>)['status'],
                                              style: TextStyle(
                                                  fontSize: (0.12 *
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width) /
                                                      3,
                                                  color: Colors.yellow[900],
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Status',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  //fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: (0.08 *
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width) /
                                                      3),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const VerticalDivider(
                                        color: Color.fromRGBO(58, 128, 203, 1),
                                        width: 1.0,
                                      ),
                                      /*InkWell(
                                          onTap: () {},
                                          child: Container(
                                              width: (0.7 *
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width -
                                                      30) /
                                                  3,
                                              height: (0.8 *
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height) /
                                                  10,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF181D3D),
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: Icon(
                                                Icons.share,
                                                size: (0.35 *
                                                        MediaQuery.of(context)
                                                            .size
                                                            .height) /
                                                    10,
                                                color: Colors.white,
                                              )),
                                        ),
                                        VerticalDivider(
                                          color: Color.fromRGBO(58, 128, 203, 1),
                                          width: 1.0,
                                        ),*/
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            /*if (_like == true) {
                                        _like = false;
                                        complaint.upvotes
                                            .remove("MY EMAIL ID: FROM BACKEND");
                                        //TODO: Upload complaint to Backend
                                      } else {
                                        _like = true;
                                        complaint.upvotes.add("MY EMAIL ID: FROM BACKEND");
                                        //TODO: Upload complaint to Backend
                                      }*/
                                          });
                                        },
                                        child: Container(
                                          width: (1.05 *
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                  30) /
                                              3,
                                          height: (0.8 *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height) /
                                              10,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF181D3D),
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.zero,
                                                bottomLeft: Radius.zero,
                                                topRight: Radius.circular((0.6 *
                                                        MediaQuery.of(context)
                                                            .size
                                                            .height) /
                                                    20),
                                                bottomRight: Radius.circular(
                                                    (0.6 *
                                                            MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height) /
                                                        20)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(Icons.arrow_upward),
                                                onPressed: () {
                                                  if ((snapshot.data!.data()
                                                              as Map<String,
                                                                  dynamic>)[
                                                          'upvotes']
                                                      .contains(FirebaseAuth
                                                          .instance
                                                          .currentUser!
                                                          .uid)) {
                                                    _complaints
                                                        .doc(
                                                            widget._complaintID)
                                                        .update({
                                                      'upvotes': FieldValue
                                                          .arrayRemove([
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid
                                                      ])
                                                    });
                                                  } else {
                                                    _complaints
                                                        .doc(
                                                            widget._complaintID)
                                                        .update({
                                                      'upvotes': FieldValue
                                                          .arrayUnion([
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid
                                                      ])
                                                    });
                                                  }
                                                },
                                                color: (snapshot.data!.data()
                                                                as Map<String,
                                                                    dynamic>)[
                                                            'upvotes']
                                                        .contains(FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid)
                                                    ? Colors.blue[400]
                                                    : Colors.grey,
                                                iconSize: (0.35 *
                                                        MediaQuery.of(context)
                                                            .size
                                                            .height) /
                                                    10,
                                              ),
                                              SizedBox(
                                                width: 4.0,
                                              ),
                                              Text(
                                                (snapshot.data!.data() as Map<
                                                        String,
                                                        dynamic>)['upvotes']
                                                    .length
                                                    .toString(),
                                                //complaint.upvotes.length.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 15.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                  );
                } else {
                  return LoadingDialogWidget();
                }
              });
        });
  }
}
