import 'package:flutter/material.dart';
import 'package:harvestx/features/home/screens/for_both/shop_screen/shop_screen.dart';
import 'package:harvestx/features/home/screens/seller/main_screens/dashboard.dart';
import 'package:harvestx/features/home/screens/seller/main_screens/upload_product_screen.dart';

import '../../../../core/common/bottom_nev_bar/bottom_nev_bar.dart';

class SellerHomePage extends StatefulWidget {
  const SellerHomePage({super.key});

  @override
  _SellerHomePageState createState() => _SellerHomePageState();
}

class _SellerHomePageState extends State<SellerHomePage> {
  int currentIndex = 0;

  final List _tabIcons = List.unmodifiable([
    {'icon': Icons.shop, 'title': 'Shop'},
    {'icon': Icons.menu_book_outlined, 'title': 'Recipes'},
    {'icon': Icons.shopping_cart, 'title': 'Cart'},
    {'icon': Icons.dashboard, 'title': 'Dashboard'},
    {'icon': Icons.upload, 'title': 'Upload'},
  ]);

  final List<Widget> _tabs = List.unmodifiable([
    ShopScreen(),
    Container(),
    Container(),
    const DashboardScreen(),
    const UploadProductScreen(),
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
