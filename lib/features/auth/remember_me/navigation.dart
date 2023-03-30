import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:harvestx/features/home/screens/costumer/home_page.dart';
import 'package:harvestx/features/home/screens/seller/home_page.dart';

import '../../../core/common/loder.dart';


class NavigationFromLogin extends StatefulWidget {
  const NavigationFromLogin({super.key});

  @override
  _NavigationFromLoginState createState() => _NavigationFromLoginState();
}

class _NavigationFromLoginState extends State<NavigationFromLogin> {
      var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future:
          FirebaseFirestore.instance.collection('users').doc(user!.email).get(),
      builder: (BuildContext context, user) {
        switch (user.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return const LoadingDialogWidget(
              message: "",
            );
          case ConnectionState.done:
            if (user.hasError) return Text('Error: ${user.error}');
            print(user.data!['type']);

            return (user.data!['type'] == 'Costumer')
                ? const CostumerHomePage()
                :  SellerHomePage();
        }
      },
    );
  }
}
