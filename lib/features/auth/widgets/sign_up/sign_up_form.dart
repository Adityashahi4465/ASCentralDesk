import 'package:as_central_desk/core/common/loader.dart';
import 'package:as_central_desk/core/utils/extensions/validators.dart';
import 'package:as_central_desk/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../component/logo_text.dart';
import '../../../../component/rounded_button.dart';
import '../../../../constants/app_constant.dart';
import '../../../../constants/campus_data.dart';
import '../../../../core/common/dropdown_button.dart';
import '../../../../core/utils/color_utility.dart';
import '../../../../core/utils/form_validation.dart';
import '../../../../core/utils/snackbar.dart';
import '../form_text_field.dart';

class SignUpForm extends ConsumerStatefulWidget {
  final Size size;
  final TextTheme textTheme;

  const SignUpForm({
    super.key,
    required this.size,
    required this.textTheme,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpFormState();
}

class _SignUpFormState extends ConsumerState<SignUpForm> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final rollNumberController = TextEditingController();
  final nameController = TextEditingController();
  String? selectedCampus;
  String? selectedCourse;
  String? selectedSem;

  void updateAvailableCourses(String newCampus) {
    if (newCampus != selectedCampus) {
      setState(() {
        selectedCampus = newCampus;
        selectedCourse = null; // Reset selected course only when campus changes
      });
    } else {
      setState(() {
        selectedCampus = newCampus;
      });
    }
  }

  void registerWithEmailAndPassword() {
    ref.read(authControllerProvider.notifier).registerWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
          name: nameController.text.trim(),
          rollNo: rollNumberController.text.trim(),
          campus: selectedCampus!,
          course: selectedCourse!,
          semester: selectedSem!,
          context: context,
        );
  }

  @override
  void dispose() {
    super.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    emailController.dispose();
    rollNumberController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final validationService = ref.watch(validationServiceProvider);
    final loading = ref.watch(authControllerProvider);
    return Padding(
      padding:
          EdgeInsets.only(top: widget.size.height * 0.15, left: 18, right: 18),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  controller: emailController,
                  textTheme: widget.textTheme,
                  validator: (value) => validationService.validateEmail(value!),
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
                  controller: nameController,
                  textTheme: widget.textTheme,
                  validator: (val) => validationService.validateName(val!),
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
                  controller: rollNumberController,
                  textTheme: widget.textTheme,
                  validator: (val) =>
                      validationService.validateRollNumber(val!),
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
                    value: selectedCampus,
                    onChanged: (newCampus) =>
                        updateAvailableCourses(newCampus!),
                    hintText: SELECT_CAMPUS_HINT,
                    validator: (value) =>
                        validationService.validateSelectCampus(value),
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
                          onTap: () => selectedCampus == null
                              ? showCustomSnackbar(
                                  context,
                                  'Please select a campus first',
                                )
                              : null,
                          child: SizedBox(
                            height: 63,
                            child: CustomDropdown<String>(
                              labelText: '',
                              items: (selectedCampus != null)
                                  ? campusCourses[selectedCampus]!
                                  : [],
                              value: selectedCourse,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedCourse = newValue!;
                                });
                              },
                              hintText: SELECT_COURSE_HINT,
                              validator: (value) => validationService
                                  .validateSelectCourse(value!),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: selectedCourse != null
                            ? SizedBox(
                                height: 63,
                                child: CustomDropdown<String>(
                                  labelText: '',
                                  items: List.generate(
                                    (selectedCourse == 'DCE' ||
                                            selectedCourse == 'BCA' ||
                                            selectedCourse == 'MLT')
                                        ? 6
                                        : 8,
                                    (index) => 'Semester ${index + 1}',
                                  ),
                                  value: selectedSem,
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedSem = newValue!;
                                    });
                                  },
                                  hintText: 'Select Semester',
                                  validator: (value) => validationService
                                      .validateSelectSemester(value!),
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
                child: CustomFormTextField(
                  controller: passwordController,
                  textTheme: widget.textTheme,
                  validator: (val) => validationService.validatePassword(val!),
                  hint: PASSWORD_AUTH_HINT,
                  suffixIcon: Icons.lock,
                  isPassword: true,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: widget.size.width * 0.1),
                child: CustomFormTextField(
                  controller: confirmPasswordController,
                  textTheme: widget.textTheme,
                  validator: (val) => validationService.validateConfirmPassword(
                    val!,
                    passwordController.text,
                  ),
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
                    child: loading
                        ? const Loader()
                        : RoundedButton(
                            text: BUTTON_SIGNUP,
                            onPressed: () {
                              print(selectedCampus);
                              print(selectedCourse);
                              print(selectedSem);
                              print(
                                  '${emailController.text.trim()},${passwordController.text}, ${confirmPasswordController.text}, ${nameController.text.trim()}, ${rollNumberController.text.trim()}');
                              if (formKey.currentState!.validate()) {
                                registerWithEmailAndPassword();
                              }
                            },
                            linearGradient: LinearGradient(
                              begin: FractionalOffset.bottomLeft,
                              end: FractionalOffset.topRight,
                              colors: [
                                Color(
                                  getColorHexFromStr(
                                    "#FF7539",
                                  ),
                                ),
                                Color(
                                  getColorHexFromStr(
                                    "#FE6763",
                                  ),
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
