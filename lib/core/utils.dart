import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.yellow,
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
    );
}

Future<FilePickerResult?> pickImage() async {
  final image = await FilePicker.platform.pickFiles(type: FileType.image);
  return image;
}

List<String> maincateg = [
  'select category',
  'Fruits',
  'Vegetables',
  'Canned Goods',
  'Dairy',
  'Meat',
  'Seafood',
  'Breads and Bakery',
  'Grains and Pasta',
  'Snacks',
  'Beverages',
];
