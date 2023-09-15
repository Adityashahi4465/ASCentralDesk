import 'package:flutter/material.dart';


class RoundedCircularButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final IconData icon;
  const RoundedCircularButton({
    super.key,
    required this.onPressed,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Material(
        elevation: 0.0,
        shape:const CircleBorder(),
        color: Colors.pinkAccent,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
