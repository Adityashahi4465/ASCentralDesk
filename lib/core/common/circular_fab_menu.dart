import 'package:flutter/material.dart';

import '../../features/home/delegates/flow_delegate.dart';
import '../../theme/app_colors.dart';

class CircularFabMenu extends StatelessWidget {
  final List<Map<String, dynamic>> fabItems;
  final double buttonSize;
  final AnimationController controller;

  const CircularFabMenu({
    Key? key,
    required this.fabItems,
    required this.buttonSize,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: FlowMenuDelegate(
        controller: controller,
        buttonSize: buttonSize,
      ),
      children: fabItems
          .asMap()
          .entries
          .map(
            (entry) => SizedBox(
              height: 60,
              width: 60,
              child: FloatingActionButton(
                backgroundColor: AppColors.primary,
                splashColor: AppColors.splashColor,
                elevation: 0,
                onPressed: () => entry.value['onPressed'](),
                child: _isIconData(entry.value['image'] ?? entry.value['icon'])
                    ? Icon(
                        entry.value['image'] ?? entry.value['icon'],
                        size: 30,
                        color: AppColors.white,
                      )
                    : Image.asset(
                        entry.value['image'] ?? entry.value['icon'],
                        width: 30,
                        height: 30,
                        color: AppColors.white,
                      ),
              ),
            ),
          )
          .toList(),
    );
  }

  bool _isIconData(dynamic item) {
    return item is IconData;
  }
}
