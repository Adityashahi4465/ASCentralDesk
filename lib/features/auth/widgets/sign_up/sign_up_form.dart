import 'package:flutter/material.dart';

import '../../../../component/logo_text.dart';
import '../../../../component/rounded_button.dart';
import '../../../../constants/app_constant.dart';
import '../../../../constants/campus_data.dart';
import '../../../../core/common/dropdown_button.dart';
import '../../../../core/utils/color_utility.dart';
import '../form_text_field.dart';

class SignUpForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function() onPressed;
  final Size size;
  final TextTheme textTheme;
  String? selectedCampus;
  String? selectedCourse;
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
    required this.selectedCampus,
    required this.selectedCourse, // Initialize the additional email controller
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
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
                  validator: (val) {
                    return '';
                  },
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
                  controller: widget.emailController,
                  textTheme: widget.textTheme,
                  validator: (val) {
                    return '';
                  },
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
                child: SizedBox(
                  width: 200,
                  height: 56,
                  child: CustomDropdown<String>(
                    labelText: '',
                    items: campusList,
                    value: widget.selectedCampus,
                    onChanged: (newValue) {
                      setState(() {
                        widget.selectedCampus = newValue!;
                      });
                    },
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
                child: SizedBox(
                  width: 200,
                  height: 56,
                  child: CustomDropdown<String>(
                    labelText: '',
                    items: (widget.selectedCampus != null)
                        ? campusCourses[widget.selectedCampus]!
                        : [],
                    value: widget.selectedCourse,
                    onChanged: (newValue) {
                      setState(() {
                        widget.selectedCampus = newValue!;
                      });
                    },
                    hintText: SELECT_COURSE_HINT,
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
                child: SizedBox(
                  child: CustomFormTextField(
                    controller: widget.passwordController,
                    textTheme: widget.textTheme,
                    validator: (val) {
                      return '';
                    },
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
                  validator: (val) {
                    return '';
                  },
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
