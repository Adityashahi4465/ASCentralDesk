
import 'package:flutter/material.dart';

class CustomFormTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextTheme textTheme;
  final String Function(String?)? validator;
  final String hint;
  final IconData? suffixIcon;
  final bool isPassword;

  const CustomFormTextField({
    super.key,
    required this.controller,
    required this.textTheme,
    required this.validator,
    required this.hint,
    required this.suffixIcon,
    required this.isPassword,
  });

  @override
  State<CustomFormTextField> createState() => _CustomFormTextFieldState();
}

class _CustomFormTextFieldState extends State<CustomFormTextField> {
  late bool isObscured = widget.isPassword ? true : false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: widget.textTheme.titleLarge!
          .copyWith(color: Colors.black87, letterSpacing: 1.2),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: widget.textTheme.titleMedium!.copyWith(
          color: Colors.grey,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isObscured = !isObscured;
                  });
                },
                icon: Icon(
                  isObscured ? widget.suffixIcon : Icons.lock_open,
                ))
            : Icon(
                widget.suffixIcon,
                color: Colors.grey,
              ),
      ),
      keyboardType: TextInputType.text,
      controller: widget.controller,
      validator: widget.validator,
      obscureText: isObscured,
    );
  }
}
