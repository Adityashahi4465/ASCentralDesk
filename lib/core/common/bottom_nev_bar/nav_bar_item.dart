import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../theme/pallet.dart';
import '../../constants/ui_constants.dart';

class NavBarItem extends StatefulWidget {
  final int index;
  final int activeIndex;
  final dynamic icon;
  final ValueChanged<int> onTabChanged;
  const NavBarItem({
    Key? key,
    this.icon,
    required this.index,
    required this.activeIndex,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  _NavBarItemState createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      lowerBound: 1,
      upperBound: 1.3,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onTap() {
    // change currentIndex to this tab's index
    if (widget.index != widget.activeIndex) {
      widget.onTabChanged(widget.index);
      _controller.forward().then((value) => _controller.reverse());
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ScaleTransition(
            scale: _controller,
            child: Icon(
              widget.icon['icon'],
              color: widget.activeIndex == widget.index ? Pallete.kPrimaryColor : null,
            ),
          ),
          // Spacer(),
          Text(
            widget.icon['title'],
            style: TextStyle(
                color:
                    widget.activeIndex == widget.index ? Pallete.kPrimaryColor : null),
          ),
        ],
      ),
    );
  }
}
