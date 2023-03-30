import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  Color? color;
   BackgroundImage({super.key , this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: color,
        child: Stack(
          children: [
            Positioned(
                top: -123,
                right: -200,
                child: Image.asset("assets/vegetables/verde.png", height: 330)),
            Positioned(
                top: 10,
                left: -200,
                child:
                    Image.asset("assets/vegetables/carrot.png", height: 330)),
            Positioned(
                bottom: -123,
                left: -150,
                child: Image.asset(
                  "assets/vegetables/brocoli.png",
                  height: 340,
                )),
            Positioned(
              bottom: -75,
              right: -50,
              child: Image.asset("assets/vegetables/rabanos.png", height: 230),
            )
          ],
        ));
  }
}
