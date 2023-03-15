import 'package:flutter/material.dart';

class CatigoryW extends StatelessWidget {
  final String image;
 final  String text;
  final Color color;
  final VoidCallback onTap;
  const CatigoryW(
      {super.key, required this.image,
      required this.text,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 177,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0x9F3D416E),
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
    );
  }
}
