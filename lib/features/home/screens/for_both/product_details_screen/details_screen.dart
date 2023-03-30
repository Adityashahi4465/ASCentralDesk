import 'package:flutter/material.dart';

import '../../../../../models/product_model.dart';

class ItemDetailsSreen extends StatefulWidget {
    static const routeName = 'item-details-screen/';
  final MGrocery item;

  const ItemDetailsSreen({super.key , required this.item});

  @override
  State<ItemDetailsSreen> createState() => _ItemDetailsSreenState();
}

class _ItemDetailsSreenState extends State<ItemDetailsSreen> {
  @override
  Widget build(BuildContext context) {
    return Text('Details');
  }
}