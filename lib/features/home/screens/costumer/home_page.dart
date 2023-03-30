import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:harvestx/features/home/screens/costumer/profile.dart';
import 'package:harvestx/features/home/screens/for_both/shop_screen/shop_screen.dart';

import '../../../../core/common/bottom_nev_bar/bottom_nev_bar.dart';

class CostumerHomePage extends StatefulWidget {
  const CostumerHomePage({super.key});

  @override
  _CostumerHomePageState createState() => _CostumerHomePageState();
}

class _CostumerHomePageState extends State<CostumerHomePage> {
  int currentIndex = 0;

  final List _tabIcons = List.unmodifiable([
    {'icon': Icons.shop, 'title': 'Shop'},
    {'icon': Icons.explore, 'title': 'Explore'},
    {'icon': Icons.shopping_cart, 'title': 'Cart'},
    {'icon': Icons.favorite, 'title': 'Favorites'},
    {'icon': Icons.person, 'title': 'Account'},
  ]);

  final List<Widget> _tabs = List.unmodifiable([
     ShopScreen(),
    Container(),
    Container(),
    Container(),
    ProfileScreen(
      documentId: FirebaseAuth.instance.currentUser!.email ?? "",
    )
  ]);

  void onTabChanged(int index) {
    setState(() => currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[currentIndex],
      bottomNavigationBar: NavBar(
        tabIcons: _tabIcons,
        activeIndex: currentIndex,
        onTabChanged: onTabChanged,
      ),
    );
  }
}
