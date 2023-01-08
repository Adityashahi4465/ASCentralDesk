import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 200,
            width: 200,
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 25),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/no_internet.png'),
              ),
            ),
          ),
          const Text(
            "No Internet Connection!",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                decoration: TextDecoration.none),
            textAlign: TextAlign.center,
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Make sure Wi-Fi or Mobile data is on, Airplane Mode is Off ',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.redAccent,
                  decoration: TextDecoration.none),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
