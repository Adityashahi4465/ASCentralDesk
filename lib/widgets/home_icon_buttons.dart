import 'package:flutter/material.dart';

class CatigoryW extends StatelessWidget {
  String image;
  String text;
  Color color;
  VoidCallback onTap;
  CatigoryW(
      {required this.image,
      required this.text,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 177,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0x9F3D416E),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              image,
              width: 110,
              height: 100,
            ),
            // SizedBox(
            //   height: 10,
            // ),
            Text(
              text,
              style: TextStyle(color: color, fontSize: 18),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
