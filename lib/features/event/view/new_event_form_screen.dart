import 'dart:io';

import 'package:as_central_desk/constants/campus_data.dart';
import 'package:as_central_desk/core/common/rounded_button.dart';
import 'package:as_central_desk/core/common/text_input_field.dart';
import 'package:as_central_desk/features/event/controller/event_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/app_constant.dart';
import '../../../core/common/dropdown_button.dart';
import '../../../core/common/form_input_heading.dart';
import '../../../core/common/loader.dart';
import '../../../core/utils/form_validation.dart';
import '../../../core/utils/snackbar.dart';
import '../../../routes/route_utils.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_style.dart';

class NewEventFormScreen extends ConsumerStatefulWidget {
  const NewEventFormScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewEventFormScreenState();
}

class _NewEventFormScreenState extends ConsumerState<NewEventFormScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
  final TextEditingController desController = TextEditingController();
  final TextEditingController criteriaController = TextEditingController();
  final TextEditingController capacityController = TextEditingController();
  final TextEditingController eventImagesController = TextEditingController();
  final TextEditingController organizerInfoController = TextEditingController();
  final TextEditingController registrationLinkController =
      TextEditingController();
  final TextEditingController contactInfoController = TextEditingController();
  final TextEditingController eventTypeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController prizeController = TextEditingController();
  static const List<String> venueTypesList = ['Online', 'Offline', 'Hybrid'];
  String? campusName;
  String? venueType;
  List<List<int>> _imageBytesList = [];
  List<String> filePaths = [];
  // picking dateTime Range
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(const Duration(days: 5)),
  );
  void saveEventToDatabase() {
    ref.read(eventControllerProvider.notifier).saveEventToDatabase(
          title: titleController.text.trim(),
          description: desController.text.trim(),
          criteria: criteriaController.text,
          campus: campusName ?? "", // Make sure to handle null if needed
          venueType: venueType ?? "", // Make sure to handle null if needed
          startDate: dateRange.start,
          endDate: dateRange.end,
          capacity: int.tryParse(capacityController.text) ?? 0,
          eventImages: _imageBytesList.isEmpty ? filePaths : _imageBytesList,
          organizerInfo: organizerInfoController.text.trim(),
          registrationLink: registrationLinkController.text.trim(),
          contactInfo: contactInfoController.text.trim(),
          eventType: eventTypeController.text.trim(),
          location: locationController.text.trim(),
          context: context,
          prize: int.tryParse(prizeController.text.trim()) ?? 0,
          subtitle: subtitleController.text.trim(),
        );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF181D3D),
              secondary: Color.fromARGB(110, 24, 29, 61),
              surface: Color.fromARGB(198, 189, 197, 220),
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (newDateRange == null) return;
    setState(() => dateRange = newDateRange);
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

  void dispose() {
    titleController.dispose();
    subtitleController.dispose();
    desController.dispose();
    criteriaController.dispose();
    capacityController.dispose();
    eventImagesController.dispose();
    organizerInfoController.dispose();
    registrationLinkController.dispose();
    contactInfoController.dispose();
    eventTypeController.dispose();
    locationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final start = dateRange.start;
    final end = dateRange.end;
    final validationService = ref.watch(validationServiceProvider);
    final loading = ref.watch(eventControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Event',
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
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextInputFieldWithToolTip(
                  controller: titleController,
                  toolTipMessage: 'Enter the Title of Event (Required)',
                  tipText: 'Event Title',
                  hintText: 'Enter The Title',
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter a Title'
                      : null,
                  maxLines: 2,
                ),
                const SizedBox(height: 16.0),
                TextInputFieldWithToolTip(
                  controller: subtitleController,
                  toolTipMessage: 'please enter subtitle',
                  tipText: 'Subtitle',
                  hintText: 'Enter The Subtitle',
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter a subtitle'
                      : null,
                  maxLines: 2,
                ),
                const SizedBox(height: 16.0),
                TextInputFieldWithToolTip(
                  controller: desController,
                  toolTipMessage: 'please enter the description of the event',
                  tipText: 'Description',
                  hintText: 'Enter Description',
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter the description of event'
                      : null,
                  maxLines: 5,
                ),
                const SizedBox(height: 16.0),
                TextInputFieldWithToolTip(
                  controller: criteriaController,
                  toolTipMessage:
                      'please enter minimum criteria to join this event',
                  tipText: 'Eligibility Criteria',
                  hintText: 'Enter Eligibility Criteria',
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter the eligibility of event'
                      : null,
                  maxLines: 2,
                ),
                const SizedBox(height: 16.0),
                TextInputFieldWithToolTip(
                  controller: capacityController,
                  toolTipMessage: 'Enter the capacity for the event',
                  tipText: 'Capacity',
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: false,
                    signed: false,
                  ),
                  hintText: 'Enter Capacity',
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter the capacity of event'
                      : null,
                  maxLines: 1,
                ),
                const SizedBox(height: 16.0),
                TextInputFieldWithToolTip(
                  controller: organizerInfoController,
                  toolTipMessage: 'Enter organizer information',
                  tipText: 'Organizer Information',
                  hintText: 'Enter Organizer Information',
                  validator: (value) =>
                      validationService.validateOrganizerInfo(value!),
                  maxLines: 2,
                ),
                const SizedBox(height: 16.0),
                TextInputFieldWithToolTip(
                  controller: registrationLinkController,
                  toolTipMessage: 'Enter the registration link for the event',
                  tipText: 'Registration Link',
                  hintText: 'Enter Registration Link',
                  validator: (value) =>
                      validationService.validateRegistrationLink(value!),
                  maxLines: 1,
                ),
                const SizedBox(height: 16.0),
                TextInputFieldWithToolTip(
                  controller: contactInfoController,
                  toolTipMessage: 'Enter contact information',
                  tipText: 'Contact Information',
                  hintText: 'Enter Contact Information',
                  validator: (value) =>
                      validationService.validateContactInfo(value!),
                  maxLines: 2,
                ),
                const SizedBox(height: 16.0),
                TextInputFieldWithToolTip(
                  controller: prizeController,
                  toolTipMessage: 'Enter Prize of event',
                  tipText: 'Prize',
                  hintText: 'Enter Prize in numbers',
                  maxLength: 6,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: false,
                    signed: false,
                  ),
                  validator: (value) =>
                      validationService.validateContactInfo(value!),
                  maxLines: 1,
                ),
                const SizedBox(height: 16.0),
                TextInputFieldWithToolTip(
                  controller: eventTypeController,
                  toolTipMessage: 'Enter the type of the event',
                  tipText: 'Event Type',
                  hintText: 'Enter Event Type',
                  validator: (value) =>
                      validationService.validateEventType(value!),
                  maxLines: 1,
                ),
                const SizedBox(height: 16.0),
                TextInputFieldWithToolTip(
                  controller: locationController,
                  toolTipMessage: 'Enter the location of the event',
                  tipText: 'Location',
                  hintText: 'Enter Location',
                  validator: (value) =>
                      validationService.validateLocation(value!),
                  maxLines: 1,
                ),
                const SizedBox(height: 16.0),
                Column(
                  children: [
                    const FormInputHeading(
                      tipMessage: SELECT_CAMPUS_TIP_MESSAGE,
                      heading: SELECT_CAMPUS_HINT,
                    ),
                    SizedBox(
                      height: 63,
                      child: CustomDropdown<String>(
                        labelText: '',
                        items: campusList,
                        value: campusName,
                        onChanged: (newCampus) {
                          setState(() {
                            campusName = newCampus;
                          });
                        },
                        hintText: SELECT_CAMPUS_HINT,
                        validator: (value) =>
                            validationService.validateSelectCampus(value),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    const SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        children: [
                          const FormInputHeading(
                            tipMessage: SELECT_VENUE_TYPE_TIP_MESSAGE,
                            heading: SELECT_VENUE_TYPE_HEADING,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: 63,
                            width: double.maxFinite,
                            child: CustomDropdown<String>(
                              labelText: 'Select Venue',
                              items: venueTypesList,
                              value: venueType,
                              onChanged: (newVenue) {
                                setState(() {
                                  venueType = newVenue!;
                                });
                              },
                              hintText: SELECT_VENUE_TYPE_HINT,
                              validator: (value) =>
                                  validationService.validateSelectVenue(value),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const FormInputHeading(
                            tipMessage:
                                'Please choose the start date for this event',
                            heading: 'Start Date',
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          InkWell(
                            onTap: pickDateRange,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                              decoration: BoxDecoration(
                                color: AppColors.lightPurpleColor,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Center(
                                child: Text(
                                  '${start.year}/${start.month}/${start.day}',
                                  style: AppTextStyle.displaySemiBold.copyWith(
                                      color: AppColors.greyColor,
                                      letterSpacing: 1.5),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        children: [
                          const FormInputHeading(
                            tipMessage:
                                'Please choose the end date for this event',
                            heading: 'End Date',
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          InkWell(
                            onTap: pickDateRange,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                              decoration: BoxDecoration(
                                color: AppColors.lightPurpleColor,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Center(
                                child: Text(
                                  '${end.year}/${end.month}/${end.day}',
                                  style: AppTextStyle.displaySemiBold.copyWith(
                                    color: AppColors.greyColor,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                const FormInputHeading(
                  tipMessage: 'Pick the images of event',
                  heading: 'Pick images of event',
                ),
                const SizedBox(height: 8.0),
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
                                        fit: BoxFit.contain,
                                        Uint8List.fromList(
                                          _imageBytesList[index],
                                        ),
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
                const SizedBox(height: 16.0),
                loading
                    ? const Loader()
                    : RoundedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            saveEventToDatabase();
                          }
                        },
                        text: 'Submit',
                        linearGradient: AppColors.roundedButtonGradient,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
