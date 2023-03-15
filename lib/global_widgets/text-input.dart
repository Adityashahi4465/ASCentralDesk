import 'package:flutter/material.dart';

import 'package:e_complaint_box/palatte.dart';

class TextInput extends StatefulWidget {
  const TextInput({
    super.key,
    required this.textEditingController,
    required this.icon,
    required this.hint,
    required this.inputType,
    required this.inputAction,
  });
  final TextEditingController? textEditingController;
  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[600]?.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
            border: InputBorder.none,
            hintText: widget.hint,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                widget.icon,
                color: Colors.white,
                size: 30,
              ),
            ),
            hintStyle: kBodyText,
          ),
          style: kBodyText,
          keyboardType: widget.inputType,
          textInputAction: widget.inputAction,
          controller: widget.textEditingController,
        ),
      ),
    );
  }
}
