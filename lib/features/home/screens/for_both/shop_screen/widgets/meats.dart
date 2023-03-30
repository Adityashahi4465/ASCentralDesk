import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../../core/mq.dart';
import '../../../../../../models/product_model.dart';
import '../../../../../../theme/pallet.dart';
import 'grocery_item.dart';

class Meats extends StatelessWidget {
  const Meats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final meatList = snapshot.data!.docs
            .map((doc) => MGrocery.fromJson(doc.data()!))
            .toList();

        return Container(
          height: MQuery.height * 0.3,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            scrollDirection: Axis.horizontal,
            itemCount: meatList.length,
            itemBuilder: (_, i) => GroceryItem(item: meatList[i]),
            separatorBuilder: (_, __) => const SizedBox(width: 10),
          ),
        );
      },
    );
  }
}
