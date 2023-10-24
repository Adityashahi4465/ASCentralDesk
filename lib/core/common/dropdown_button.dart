import 'package:as_central_desk/core/utils/color_utility.dart';
import 'package:as_central_desk/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String labelText;
  final String hintText;
  final List<T> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String? Function(T?)? validator;

  const CustomDropdown({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      elevation: 2,
      isExpanded: true,
      iconSize: 40,
      iconEnabledColor: Colors.grey,
      iconDisabledColor: Colors.grey,
      focusColor: AppColors.primary,
      validator: validator,
      menuMaxHeight: 400,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primary, // Customize the color as needed
            width: 1.5, // Adjust the width of the bottom border
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey, // Customize the color as needed
            width: 1.0, // Adjust the width of the bottom border
          ),
        ),
      ),
      value: value,
      hint: Text(
        hintText,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      onChanged: onChanged,
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(
            item.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.6),
            ),
          ),
        );
      }).toList(),
    );
  }
}
