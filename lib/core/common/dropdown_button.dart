import 'package:as_central_desk/core/utils/color_utility.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String labelText;
  final String hintText;
  final List<T> items;
  final T? value;
  final ValueChanged<T?> onChanged;

  const CustomDropdown({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      elevation: 2,
      isExpanded: true,
      iconSize: 40,
      iconEnabledColor: Colors.grey,
      iconDisabledColor: Colors.grey,
      menuMaxHeight: 400,
      underline: Container(
        height: 1,
        color: Colors.grey,
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
