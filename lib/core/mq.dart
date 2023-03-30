import 'package:flutter/material.dart';

class MQuery {
  static late  double width;
  static late double height;
  
  void init(BuildContext context) {
    final MediaQueryData _mediaQueryData = MediaQuery.of(context);
    width = _mediaQueryData.size.width;    
    height = _mediaQueryData.size.height;    
  }
}