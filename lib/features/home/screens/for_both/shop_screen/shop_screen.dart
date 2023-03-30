import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/mq.dart';
import '../../../../../theme/pallet.dart';
import 'widgets/banners.dart';
import 'widgets/best_selling.dart';
import 'widgets/exlusive_offers.dart';
import 'widgets/groceries.dart';
import 'widgets/meats.dart';
import 'widgets/search_field.dart';

class ShopScreen extends StatelessWidget {
  @override
  final Stream<QuerySnapshot> _sliderStream =
      FirebaseFirestore.instance.collection('slider').snapshots();

  Widget build(BuildContext context) {
    MQuery().init(context);
    return SafeArea(
      child: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Column(
            children: [
              Image.asset(
                'assets/vegetables/carrot.png',
                height: 50,
              ),
              const SizedBox(height: 5),
              const Text(
                'HarvestX',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const SearchField(),
              const SizedBox(height: 10),
              Banners(),
              const SizedBox(height: 10),
              _buildSectiontitle('Best Sellings', () {}),
              BestSellings(),
              const SizedBox(height: 10),
              _buildSectiontitle('Vegetables', () {}),
              Vegetables(),
              const SizedBox(height: 10),
              _buildSectiontitle('Groceries', () {}),
              Groceries(),
              const SizedBox(height: 10),
              _buildSectiontitle('Meats', () {}),
              Meats(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectiontitle(String title, [Function()? onTap]) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Pallete.kTitleStyle.copyWith(fontSize: 18),
          ),
          InkWell(
            onTap: onTap ?? () {},
            child: Text(
              'See all',
              style: TextStyle(color: Pallete.kPrimaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
