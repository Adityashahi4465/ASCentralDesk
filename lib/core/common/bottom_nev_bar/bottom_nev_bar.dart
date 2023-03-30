import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


import '../../../theme/pallet.dart';
import '../../constants/ui_constants.dart';
import 'nav_bar_item.dart';

class NavBar extends StatelessWidget {
  final List _tabIcons;
  final int activeIndex;
  final ValueChanged<int> onTabChanged;
  const NavBar({
    Key? key,
    required List tabIcons,
   required this.activeIndex,
   required this.onTabChanged,
  })  : _tabIcons = tabIcons,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            color: Pallete.kShadowColor.withOpacity(0.14),
            blurRadius: 25,
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(_tabIcons.length, (index) {
          return NavBarItem(
            icon: _tabIcons[index],
            index: index,
            activeIndex: activeIndex,
            onTabChanged: onTabChanged,
          );
        }),
      ),
    );
  }
}

