import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Pallete {
  // Colors

  static const Color primaryGreen = Color(0xff296343);

  static const Color greenSecondary = Color(0xff357C5C);
  static Color kPrimaryColor = HexColor('#53B175');
  static Color kShadowColor = HexColor('#A8A8A8');
  static Color kBlackColor = HexColor('#181725');
  static Color kSubtitleColor = HexColor('#7C7C7C');
  static Color kSecondaryColor = HexColor('#F2F3F2');
  static Color kBorderColor = HexColor('#E2E2E2');

  static TextStyle kTitleStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: kBlackColor,
  );

  static TextStyle kDescriptionStyle = TextStyle(
    color: kSubtitleColor,
    fontSize: 13,
  );

  static const blackColor = Color.fromRGBO(1, 1, 1, 1); // primary color
  static const greyColor = Color.fromRGBO(26, 39, 45, 1); // secondary color
  static const drawerColor = Color.fromRGBO(18, 18, 18, 1);
  static const purpleBgColor = Color(0xff9232E9);
  static const pink = Color(0xffC026D3);

  static const whiteColor = Colors.white;
  static var redColor = Colors.red.shade500;
  static var blueColor = Colors.blue.shade300;
  static var dividerColor = const Color.fromARGB(103, 166, 161, 252);
  static var buttonColor = const Color.fromARGB(103, 166, 161, 252);

  // Themes
  static var darkModeAppTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: blackColor,
    cardColor: greyColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: drawerColor,
      iconTheme: IconThemeData(
        color: whiteColor,
      ),
      titleTextStyle: TextStyle(
        color: whiteColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: drawerColor,
    ),
    primaryColor: redColor,
    backgroundColor:
        drawerColor, // will be used as alternative background color
  );

  static var lightModeAppTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: whiteColor,
    cardColor: greyColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: whiteColor,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: blackColor,
      ),
      iconTheme: IconThemeData(
        color: blackColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: whiteColor,
    ),
    primaryColor: redColor,
    backgroundColor: whiteColor,
  );
}
