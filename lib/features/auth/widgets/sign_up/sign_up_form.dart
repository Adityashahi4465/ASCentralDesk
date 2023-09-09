import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../component/logo_text.dart';
import '../../../../component/rounded_button.dart';
import '../../../../constants/app_constant.dart';
import '../../../../constants/campus_data.dart';
import '../../../../core/common/dropdown_button.dart';
import '../../../../core/utils/color_utility.dart';
import '../../../../core/utils/form_validators.dart';
import '../../../../core/utils/snakbar.dart';
import '../form_text_field.dart';

// ignore: must_be_immutable
class SignUpForm extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function() onPressed;
  final Size size;
  final TextTheme textTheme;
  String? selectedCampus;
  String? selectedCourse;
  String? selectedSem;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController
      rollNumberController; // Add roll number controller
  final TextEditingController nameController; // Add additional email controller

  SignUpForm({
    super.key,
    required this.formKey,
    required this.onPressed,
    required this.size,
    required this.textTheme,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.rollNumberController, // Initialize the roll number controller
    required this.nameController,
    this.selectedCampus,
    this.selectedCourse,
    this.selectedSem,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpFormState();
}

class _SignUpFormState extends ConsumerState<SignUpForm> {
  void updateAvailableCourses(String newCampus) {
    if (newCampus != widget.selectedCampus) {
      setState(() {
        widget.selectedCampus = newCampus;
        widget.selectedCourse =
            null; // Reset selected course only when campus changes
      });
    } else {
      setState(() {
        widget.selectedCampus = newCampus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final validationService = ref.watch(validationServiceProvider);

    return Padding(
      padding:
          EdgeInsets.only(top: widget.size.height * 0.15, left: 24, right: 24),
      child: SingleChildScrollView(
        child: Form(
          key: widget.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: widget.size.width * 0.1),
                child: LogoText(),
              ),
              const SizedBox(
                height: 48,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: widget.size.width * 0.1),
                child: CustomFormTextField(
                  controller: widget.emailController,
                  textTheme: widget.textTheme,
                  validator: (val) => validationService.validateEmail(val)!,
                  hint: EMAIL_AUTH_HINT,
                  suffixIcon: Icons.person,
                  isPassword: false,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.size.width * 0.1,
                ),
                child: CustomFormTextField(
                  controller: widget.nameController,
                  textTheme: widget.textTheme,
                  validator: (val) => validationService.validateName(val)!,
                  hint: NAME_AUTH_HINT,
                  suffixIcon: Icons.person,
                  isPassword: false,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.size.width * 0.1,
                ),
                child: CustomFormTextField(
                  controller: widget.rollNumberController,
                  textTheme: widget.textTheme,
                  validator: (val) => validationService.validateEmail(val)!,
                  hint: ROLL_NUMBER_AUTH_HINT,
                  suffixIcon: Icons.person,
                  isPassword: false,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.size.width * 0.1,
                ),
                child: SizedBox(
                  height: 63,
                  child: CustomDropdown<String>(
                    labelText: '',
                    items: campusList,
                    value: widget.selectedCampus,
                    onChanged: (newCampus) =>
                        updateAvailableCourses(newCampus!),
                    hintText: SELECT_CAMPUS_HINT,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.size.width * 0.1,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 8), // Add spacing between the dropdowns
                        child: GestureDetector(
                          onTap: () => widget.selectedCampus == null
                              ? showCustomSnackbar(
                                  context,
                                  'Please select a campus first',
                                )
                              : null,
                          child: SizedBox(
                            height: 63,
                            child: CustomDropdown<String>(
                              labelText: '',
                              items: (widget.selectedCampus != null)
                                  ? campusCourses[widget.selectedCampus]!
                                  : [],
                              value: widget.selectedCourse,
                              onChanged: (newValue) {
                                setState(() {
                                  widget.selectedCourse = newValue!;
                                });
                              },
                              hintText: SELECT_COURSE_HINT,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: widget.selectedCourse != null
                            ? SizedBox(
                                height: 63,
                                child: CustomDropdown<String>(
                                  labelText: '',
                                  items: List.generate(
                                    (widget.selectedCourse == 'DCE' ||
                                            widget.selectedCourse == 'BCA' ||
                                            widget.selectedCourse == 'MLT')
                                        ? 6
                                        : 8,
                                    (index) => 'Semester ${index + 1}',
                                  ),
                                  value: widget.selectedSem,
                                  onChanged: (newValue) {
                                    setState(() {
                                      widget.selectedSem = newValue!;
                                    });
                                  },
                                  hintText: 'Select Semester',
                                ),
                              )
                            : Container(), // If no course is selected, show an empty container
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.size.width * 0.1,
                ),
                child: SizedBox(
                  child: CustomFormTextField(
                    controller: widget.passwordController,
                    textTheme: widget.textTheme,
                    validator: (val) =>
                        validationService.validatePassword(val)!,
                    hint: PASSWORD_AUTH_HINT,
                    suffixIcon: Icons.lock,
                    isPassword: true,
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: widget.size.width * 0.1),
                child: CustomFormTextField(
                  controller: widget.confirmPasswordController,
                  textTheme: widget.textTheme,
                  validator: (val) => validationService.validateConfirmPassword(
                      val, widget.confirmPasswordController.text)!,
                  hint: CONFIRM_PASSWORD_AUTH_HINT,
                  suffixIcon: Icons.lock,
                  isPassword: true,
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              Align(
                alignment: FractionalOffset.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(right: widget.size.width * 0.05),
                  child: SizedBox(
                    width: 200,
                    child: RoundedButton(
                      text: BUTTON_SIGNUP,
                      onPressed: widget.onPressed,
                      linearGradient: LinearGradient(
                        begin: FractionalOffset.bottomLeft,
                        end: FractionalOffset.topRight,
                        colors: <Color>[
                          Color(
                            getColorHexFromStr("#FF7539"),
                          ),
                          Color(
                            getColorHexFromStr("#FE6763"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
