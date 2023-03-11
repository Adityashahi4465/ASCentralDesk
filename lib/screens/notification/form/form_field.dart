import 'package:flutter/material.dart';

class FormFieldHintToolTip extends StatelessWidget {
  final TextEditingController controller;
  final String toolTipMessage;
  final String tipText;
  final String hintText;
  final int maxLines;
  final String? Function(String?)? validator;
  const FormFieldHintToolTip(
      {super.key,
      required this.toolTipMessage,
      required this.tipText,
      required this.hintText,
      required this.validator,
      required this.controller,
      required this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              tipText,
              style: const TextStyle(color: Color.fromARGB(255, 4, 111, 211)),
            ),
            const SizedBox(
              width: 10,
            ),
            Tooltip(
              message: toolTipMessage,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(66, 178, 197, 255),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: Colors.grey.shade600,
                  ),
                ),
                child: const Icon(
                  Icons.question_mark,
                  size: 14,
                  color: Color.fromARGB(255, 157, 190, 248),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          maxLines: maxLines,
          controller: controller,
          style: const TextStyle(color: Colors.black87, fontSize: 16),
          decoration: InputDecoration(
            hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.5,
                color: Color.fromARGB(255, 16, 114, 176),
              ),
            ),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 0.5,
                color: Color.fromARGB(255, 29, 17, 121),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 1.5,
                color: Color.fromARGB(255, 10, 16, 108),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 1,
                color: Color.fromARGB(222, 228, 32, 32),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 1.5,
                color: Color.fromARGB(222, 230, 6, 6),
              ),
            ),
            hintText: hintText,
          ),
          validator: validator,
        ),
      ],
    );
  }
}
