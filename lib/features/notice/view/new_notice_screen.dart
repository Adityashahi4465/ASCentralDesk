import 'package:as_central_desk/constants/ui_constants.dart';
import 'package:as_central_desk/core/utils/extensions/enum_to_string.dart';
import 'package:as_central_desk/features/notice/controller/notice_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../constants/app_constant.dart';
import '../../../constants/campus_data.dart';
import '../../../core/common/dropdown_button.dart';
import '../../../core/common/form_input_heading.dart';
import '../../../core/common/loader.dart';
import '../../../core/common/rounded_button.dart';
import '../../../core/common/text_input_field.dart';
import '../../../core/enums/enums.dart';
import '../../../core/utils/form_validation.dart';
import '../../../routes/route_utils.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_style.dart';
import '../../event/controller/event_controller.dart';

class NewNoticeFormScreen extends ConsumerStatefulWidget {
  const NewNoticeFormScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewNoticeFormScreenState();
}

class _NewNoticeFormScreenState extends ConsumerState<NewNoticeFormScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController desController = TextEditingController();
  final TextEditingController contactDetailsController =
      TextEditingController();
  final TextEditingController relatedNoticesLinkController =
      TextEditingController();
  List<String> selectedCampuses = [];
  String? selectedPriority;
  String? selectedVisibility;
  String? selectedCategory;

  // picking dateTime Range
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(const Duration(days: 5)),
  );
  void saveNoticeToDatabase() {
    ref.read(noticeControllerProvider.notifier).saveNoticeToDatabase(
          title: titleController.text,
          description: desController.text,
          category: selectedCategory ?? "NA",
          campuses: selectedCampuses,
          visibility:
              selectedVisibility ?? NoticeVisibility.restricted.toShortString(),
          priority: selectedPriority ?? NoticePriority.medium.toShortString(),
          startDate: dateRange.start,
          endDate: dateRange.end,
          relatedNoticesLink: relatedNoticesLinkController.text,
          contact: contactDetailsController.text,
          context: context,
        );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (newDateRange == null) return;
    setState(
      () => dateRange = newDateRange,
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    desController.dispose();
    contactDetailsController.dispose();
    relatedNoticesLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;
    final validationService = ref.watch(validationServiceProvider);
    final loading = ref.watch(noticeControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Notice',
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
                  toolTipMessage: 'Enter the Title of Notice (Required)',
                  tipText: 'Notice Title',
                  hintText: 'Notice The Title',
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter a Title'
                      : null,
                  maxLines: 2,
                  maxLength: 80,
                ),
                const SizedBox(height: 16.0),
                TextInputFieldWithToolTip(
                  controller: desController,
                  toolTipMessage:
                      'please enter the description of the notice',
                  tipText: 'Description',
                  hintText: 'Enter Description',
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter the description of notice'
                      : null,
                  maxLines: 5,
                  maxLength: 1000,
                ),
                const SizedBox(height: 16.0),
                TextInputFieldWithToolTip(
                  controller: relatedNoticesLinkController,
                  toolTipMessage: 'Enter the related notices link',
                  tipText: 'Related notices Link',
                  hintText: 'Enter Related Notices Link',
                  validator: (value) =>
                      validationService.validateRegistrationLink(value!),
                  maxLines: 2,
                  maxLength: 1000,
                ),
                const SizedBox(height: 16.0),
                TextInputFieldWithToolTip(
                  controller: contactDetailsController,
                  toolTipMessage: 'Enter the contact details',
                  tipText: 'Contact Details',
                  hintText: 'Enter Contact Details',
                  validator: (value) =>
                      validationService.validateRegistrationLink(value!),
                  maxLines: 2,
                  maxLength: 1000,
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Dropdown for Priority
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FormInputHeading(
                            tipMessage: 'Select priority of the notice',
                            heading: 'Select Priority',
                          ),
                          CustomDropdown<String>(
                            labelText: 'Priority',
                            hintText: 'Select Priority',
                            items: NoticePriority.values
                                .map((value) => value.toShortString())
                                .toList(),
                            value: selectedPriority,
                            onChanged: (value) {
                              setState(() {
                                selectedPriority = value!;
                              });
                            },
                            validator: (value) {
                              return value == null
                                  ? 'Please select priority'
                                  : null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    // Dropdown for Visibility
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FormInputHeading(
                            tipMessage: 'Select visibility of the notice',
                            heading: 'Select Visibility',
                          ),
                          CustomDropdown<String>(
                            labelText: 'Visibility',
                            hintText: 'Select Visibility',
                            items: NoticeVisibility.values
                                .map((value) => value.toShortString())
                                .toList(),
                            value: selectedVisibility,
                            onChanged: (value) {
                              setState(() {
                                selectedVisibility = value!;
                              });
                            },
                            validator: (value) {
                              return value == null
                                  ? 'Please select visibility'
                                  : null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FormInputHeading(
                      tipMessage: 'Select category',
                      heading: 'Select Category',
                    ),
                    CustomDropdown<String>(
                      labelText: 'Category',
                      hintText: 'Select Category',
                      items: UiConstants.universityNoticeCategories,
                      value: selectedCategory,
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value!;
                        });
                      },
                      validator: (value) {
                        return value == null
                            ? 'Please select category'
                            : null;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Column(
                  children: [
                    const FormInputHeading(
                      tipMessage: SELECT_CAMPUS_TIP_MESSAGE,
                      heading: SELECT_CAMPUS_HINT,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    MultiSelectDropDown(
                      showClearIcon: true,
                      onOptionSelected: (options) {
                        debugPrint(options.toString());
                        setState(() {
                          selectedCampuses = options
                              .map((item) => item.value.toString())
                              .toList();
                        });
                      },
                      options: ['All Campuses', ...campusList]
                          .map(
                            (e) => ValueItem(
                              label: e,
                              value: e,
                            ),
                          )
                          .toList(),
                      selectionType: SelectionType.multi,
                      chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                      dropdownHeight: 300,
                      optionTextStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      selectedOptionIcon: const Icon(Icons.check_circle),
                    ),
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
                                'Please choose the start date for this notice',
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
                                  style: AppTextStyle.displaySemiBold
                                      .copyWith(
                                          color: AppColors.black,
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
                                'Please choose the end date for this notice',
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
                                  style:
                                      AppTextStyle.displaySemiBold.copyWith(
                                    color: AppColors.black,
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
                loading
                    ? const Loader()
                    : RoundedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            saveNoticeToDatabase();
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
