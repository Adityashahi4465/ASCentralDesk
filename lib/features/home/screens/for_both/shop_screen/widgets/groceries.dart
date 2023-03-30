import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../../core/mq.dart';
import '../../../../../../models/product_model.dart';
import '../../../../../../theme/pallet.dart';

class Groceries extends StatelessWidget {
  const Groceries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final groceriesList = snapshot.data!.docs
            .map((doc) => MGroceries.fromJson(doc.data()))
            .toList();

        return Container(
          height: MQuery.height * 0.13,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            scrollDirection: Axis.horizontal,
            itemCount: groceriesList.length,
            itemBuilder: (_, i) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: MQuery.width * 0.6,
              decoration: BoxDecoration(
                color: HexColor(groceriesList[i].color.toString())
                    .withOpacity(0.15),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Image.network(groceriesList[i].url),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      groceriesList[i].title,
                      overflow: TextOverflow.ellipsis,
                      style: Pallete.kTitleStyle,
                    ),
                  ),
                ],
              ),
            ),
            separatorBuilder: (_, __) => const SizedBox(width: 10),
          ),
        );
      },
    );
  }
}
