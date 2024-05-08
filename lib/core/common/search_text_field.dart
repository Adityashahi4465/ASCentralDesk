import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Set your desired background color
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            blurStyle: BlurStyle.outer,
            color: AppColors.lightShadowColor,
            blurRadius: 6, // Adjust the blur radius as needed
            spreadRadius: 0.1, // Adjust the spread radius as needed
            offset: Offset(0, 0), // Adjust the offset as needed
          ),
        ],
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ), // Set your desired inner padding

          suffixIcon: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.filter_alt_sharp,
                color: AppColors.white,
              ),
            ),
          ),
          hintText: 'Search events...',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
