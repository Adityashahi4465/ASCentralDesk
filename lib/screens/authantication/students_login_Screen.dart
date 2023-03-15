// ignore_for_file: use_build_context_synchronously, file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:e_complaint_box/global/global.dart';
import 'package:e_complaint_box/global_widgets/loding_dialog.dart';
import 'package:e_complaint_box/palatte.dart';
import 'package:e_complaint_box/screens/authantication/registrationScreen.dart';
import 'package:e_complaint_box/screens/authantication/verify_email.dart';

import '../../services/connectivity_provider.dart';
import '../../widgets/widgets.dart';
import 'No_internet.dart';
import 'forgot_password.dart';

class StudentLoginPage extends StatefulWidget {
  const StudentLoginPage({super.key});
  @override
  State<StudentLoginPage> createState() => _StudentLoginPageState();
}

class _StudentLoginPageState extends State<StudentLoginPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    return pageUI();
  }
}

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  formValidation() async {
    if (emailTextEditingController.text.isNotEmpty &&
        passwordTextEditingController.text.isNotEmpty) {
      // TODO 1. check is password and email is correct or not
      // TODO 2. sign in
      loginNow();
    } else {
      Fluttertoast.showToast(msg: "Please fill all mandatory fields");
    }
  }

  loginNow() async {
    showDialog(
        context: context,
        builder: (c) {
          return const LoadingDialogWidget(
            message: "Checking Credentials",
          );
        });
    User? currentUser;
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailTextEditingController.text.trim(),
            password: passwordTextEditingController.text.trim())
        .then((auth) {
      currentUser = auth.user;
    }).catchError((errorMassage) {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "An Error Occurred: \n $errorMassage",
          toastLength: Toast.LENGTH_LONG);
    });
    if (currentUser != null) {
      checkIfUserExists(currentUser!);
    }
  }

  checkIfUserExists(User currentUser) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid) // specific user by their uid
        .get() // getting the record of user
        .then(
            (record) async // records of the user available in FIreStore assigned to the record variable
            {
      if (record.exists) {
        // If the record available
        // record exists
        if (record.data()!["isApproved"] == true) {
          // status is approved
          await sharedPreferences!.setString(
              "uid", currentUser.uid); // getting data this from authentication
          await sharedPreferences!.setString("email",
              currentUser.email!); // getting data this from authentication
          await sharedPreferences!.setString(
              "name",
              record.data()![
                  "name"]); // getting data this from record i.e. form FireStore
          await sharedPreferences!
              .setString("photoUrl", record.data()!["photoUrl"]);
          await sharedPreferences!.setString(
              "type",
              record.data()![
                  "type"]); // getting data this from record i.e. form FireStore

          List<String> userComplaintsList = record
              .data()!["list of my filed Complaints"]
              .cast<
                  String>(); // All the available complaint related to the user
          await sharedPreferences!
              .setStringList("list of my filed Complaints", userComplaintsList);
          //sand user to home screen
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (c) => const VerifyEmailPage(),
            ),
          );
        } else {
          // status is not approved
          FirebaseAuth.instance.signOut();
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg:
                  "you have BLOCKED by admin. \n contact Admin : adityakmcs@gmail.com",
              toastLength: Toast.LENGTH_LONG);
        }
      } else {
        // record not exists
        FirebaseAuth.instance.signOut();
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: "This user record dose not exists",
            toastLength: Toast.LENGTH_LONG);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                    child: Center(
                      child: Text(
                        'E-ASComplaint',
                        style: kHeading,
                      ),
                    ),
                  ),
                  Image.asset(
                    "assets/images/splash.png",
                    height: 220,
                    width: 220,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        Form(
                          key: formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextInput(
                                textEditingController:
                                    emailTextEditingController,
                                icon: FontAwesomeIcons.solidEnvelope,
                                hint: 'Email',
                                inputType: TextInputType.emailAddress,
                                inputAction: TextInputAction.next,
                              ),
                              PasswordInput(
                                textEditingController:
                                    passwordTextEditingController,
                                icon: FontAwesomeIcons.lock,
                                hint: 'Password',
                                inputAction: TextInputAction.done,
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPasswordPage())),
                                child: const Text(
                                  'Forgot Password?',
                                  style: kBodyText,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 100,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  formValidation();
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.0),
                                  child: Text(
                                    'Log In',
                                    style: kBodyText,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(color: Colors.white, width: 1),
                              )),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegistrationPage()));
                                },
                                child: const Text(
                                  'Not Have an Account?',
                                  style: kBodyText,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget pageUI() {
  return Consumer<ConnectivityProvider>(builder: (context, model, child) {
    if (model.isOnline != null) {
      return model.isOnline ? const LoginUI() : const NoInternet();
    }
    return Container(
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  });
}
