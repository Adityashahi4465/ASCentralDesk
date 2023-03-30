import 'package:flutter/material.dart';

var textFormDecoration = InputDecoration(
  labelText: 'Full Name',
  hintText: 'Enter your full name',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
  ),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: const BorderSide(color: Colors.purple, width: 1)),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: const BorderSide(color: Colors.purpleAccent, width: 2)),
);
