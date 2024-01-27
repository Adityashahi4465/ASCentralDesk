import 'dart:math';

import 'package:flutter/material.dart';

class FlowMenuDelegate extends FlowDelegate {
  final Animation<double> controller;
  final double buttonSize;
  const FlowMenuDelegate({required this.controller, required this.buttonSize})
      : super(repaint: controller);
  @override
  void paintChildren(FlowPaintingContext context) {
    final n = context.childCount;
    final size = context.size;

    final xStart = size.width - buttonSize;
    final yStart = size.height - buttonSize;
    for (int i = 0; i < n; i++) {
      final radius = 180 * controller.value;

      final isLastItem = i == context.childCount - 1;
      setValue(value) => isLastItem ? 0.0 : value;
      final theta = i * pi * 0.5 / (n - 2);
      final x = xStart - setValue(radius * cos(theta));
      final y = yStart - setValue(radius * sin(theta));
      context.paintChild(
        i,
        transform: Matrix4.identity()
          ..translate(x, y, 0)
          ..translate(buttonSize / 2, buttonSize / 2)
          ..rotateZ(
            isLastItem
                ? (-65 * controller.value) * pi / 90
                : 180 * (1 - controller.value) * pi / 180,
          )
          ..scale(isLastItem ? 1.0 : max(controller.value, 0.5))
          ..translate(-buttonSize / 2, -buttonSize / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}
