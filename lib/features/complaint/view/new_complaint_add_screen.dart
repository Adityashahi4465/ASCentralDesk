import 'dart:io';

import 'package:as_central_desk/apis/complaint_api.dart';
import 'package:as_central_desk/constants/app_constant.dart';
import 'package:as_central_desk/constants/campus_data.dart';
import 'package:as_central_desk/constants/ui_constants.dart';
import 'package:as_central_desk/core/common/dropdown_button.dart';
import 'package:as_central_desk/core/common/loader.dart';
import 'package:as_central_desk/core/common/rounded_button.dart';
import 'package:as_central_desk/core/common/text_input_field.dart';
import 'package:as_central_desk/core/utils/snackbar.dart';
import 'package:as_central_desk/routes/route_utils.dart';
import 'package:as_central_desk/theme/app_colors.dart';
import 'package:as_central_desk/theme/app_text_style.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dotted_border/dotted_border.dart';

import '../controller/compliant_controller.dart';

class NewComplaintFormScreen extends ConsumerStatefulWidget {
  const NewComplaintFormScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewComplaintFormScreenState();
}

class _NewComplaintFormScreenState
    extends ConsumerState<NewComplaintFormScreen> {
  File? bannerFile;
  File? profileFile;
  Uint8List? bannerWebFile;
  Uint8List? profileWebFile;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  String? selectedCategory;
  String? selectedCampus;
  List<List<int>> _imageBytesList = [];
  List<String> filePaths = [];

// TODO:sand camus data
  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  void saveComplaintToDatabase() {
    ref.read(controllerProvider.notifier).saveComplaintToDatabase(
          title: _titleController.text,
          description: _descriptionController.text,
          imagesData: _imageBytesList.isEmpty ? filePaths : _imageBytesList,
          category: selectedCategory!,
          context: context,
        );
  }

  Future<void> pickImages() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'jpeg', 'svg', 'tiff'],
      );

      if (result != null) {
        if (result.files.any((file) => file.bytes != null)) {
          // If any file has bytes, it means we are on the web
          setState(() {
            _imageBytesList = result.files.map((file) => file.bytes!).toList();
          });
        } else {
          // If no file has bytes, it means we are on Android or iOS
          setState(() {
            filePaths = result.files.map((file) => file.path!).toList();
          });
          // Now you can do something with these file paths
          print('File Paths: $filePaths');
        }
      } else {
        // ignore: use_build_context_synchronously
        showCustomSnackbar(context, 'Process Canceled by User');
      }
    } catch (e) {
      // Handle the error
      print('Error picking images: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(controllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Complaint',
          style: AppTextStyle.displayBlack.copyWith(
            color: AppColors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: AppColors.black,
            size: 30,
          ),
          onPressed: () => Navigation.navigateToBack(context),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: GestureDetector(
                    onTap: pickImages,
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      dashPattern: const [10, 4],
                      strokeCap: StrokeCap.round,
                      color: Colors.black,
                      child: _imageBytesList.isEmpty && filePaths.isEmpty
                          ? const Center(
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 40,
                              ),
                            )
                          : PageView.builder(
                              itemCount: filePaths.isEmpty
                                  ? _imageBytesList.length
                                  : filePaths.length,
                              itemBuilder: (context, index) {
                                return filePaths.isEmpty
                                    ? Image.memory(
                                        fit: BoxFit.cover,
                                        Uint8List.fromList(
                                            _imageBytesList[index]),
                                      )
                                    : Image.file(
                                        File(filePaths[index]),
                                        scale: 0.1,
                                        filterQuality: FilterQuality.medium,
                                        fit: BoxFit.contain,
                                      );
                              },
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextInputFieldWithToolTip(
                  controller: _titleController,
                  toolTipMessage: 'What\'s the title of your complaint?',
                  tipText: 'Complaint Title',
                  hintText: 'Enter the title',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return FIELD_VALIDATION_EMPTY;
                    }
                    return null;
                  },
                  maxLines: 2,
                  keyboardType: TextInputType.text,
                ),
                TextInputFieldWithToolTip(
                  controller: _descriptionController,
                  toolTipMessage: 'What\'s the description of your complaint?',
                  tipText: 'Complaint Description',
                  hintText: 'Enter the title',
                  validator: (value) {
                    return null;
                  },
                  maxLines: 2,
                  keyboardType: TextInputType.text,
                ),
                CustomDropdown(
                  labelText: 'Category',
                  hintText: 'Select Category',
                  items: UiConstants.complaintCategories,
                  value: selectedCategory,
                  onChanged: (newValue) {
                    setState(() {
                      selectedCategory = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return SELECT_CATEGORY_EMPTY;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomDropdown(
                  labelText: 'Targeted campus for complaint',
                  hintText: 'Select Campus',
                  items: campusList,
                  value: selectedCampus,
                  onChanged: (newValue) {
                    setState(() {
                      selectedCampus = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return SELECT_CAMPUS_EMPTY;
                    }
                    return null;
                  },
                ),
                loading
                    ? const Loader()
                    : RoundedButton(
                        onPressed: saveComplaintToDatabase,
                        text: 'Submit',
                        linearGradient: AppColors.orangeGradient,
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
