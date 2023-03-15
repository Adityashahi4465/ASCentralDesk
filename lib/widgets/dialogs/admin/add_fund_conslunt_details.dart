import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../models/complaints_class.dart';
import '../../../screens/notification/form/form_field.dart';

class AddFundDialogue extends StatefulWidget {
  final String complaintId;
  const AddFundDialogue({required this.complaintId, super.key});

  @override
  State<AddFundDialogue> createState() => _AddFundDialogueState();
}

class _AddFundDialogueState extends State<AddFundDialogue> {
  final TextEditingController consultsController = TextEditingController();
  final TextEditingController fundController = TextEditingController();
  bool isFundAllocated = true;
  CollectionReference complaintsDB =
      FirebaseFirestore.instance.collection('complaints');
  updateData() async {
    try {
      await complaintsDB.doc(widget.complaintId).update({
        'consults': consultsController.text,
        'fund': int.parse(fundController.text.trim()),
        'status': status[3]
      });
      Navigator.pop(context, true);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
          children: [
            FormFieldHintToolTip(
              controller: consultsController,
              toolTipMessage: 'Enter the any consults',
              tipText: 'Type your consults',
              hintText: 'Enter The Consults',
              validator: null,
              maxLines: 4,
            ),
            const SizedBox(height: 16.0),
            Switch(
              value: isFundAllocated,
              onChanged: ((value) {
                setState(() {
                  isFundAllocated = !isFundAllocated;
                });
              }),
            ),
            isFundAllocated
                ? FormFieldHintToolTip(
                    controller: fundController,
                    toolTipMessage:
                        'please enter fund invested in this complaint in INR*',
                    tipText: 'Funds',
                    hintText: 'Enter The Fund in INR',
                    validator: null,
                    maxLines: 1,
                  )
                : const SizedBox(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context, false),
                  child: Container(
                    //color: Color(0xFF181D3D),
                    width: (0.7 * MediaQuery.of(context).size.width - 30) / 2,
                    height: (0.6 * MediaQuery.of(context).size.height) / 10,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              (0.6 * MediaQuery.of(context).size.height) / 20),
                          bottomLeft: Radius.circular(
                              (0.6 * MediaQuery.of(context).size.height) / 20),
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
                  onTap: updateData,
                  child: Container(
                    //color: Color(0xFF181D3D),
                    width: (0.7 * MediaQuery.of(context).size.width - 30) / 2,
                    height: (0.6 * MediaQuery.of(context).size.height) / 10,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.zero,
                          bottomLeft: Radius.zero,
                          topRight: Radius.circular(
                              (0.6 * MediaQuery.of(context).size.height) / 20),
                          bottomRight: Radius.circular(
                              (0.6 * MediaQuery.of(context).size.height) / 20)),
                    ),
                    child: const Center(
                      child: Text(
                        "Confirm",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
