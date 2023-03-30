// ignore_for_file: use_build_context_synchronously, file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:harvestx/features/auth/remember_me/navigation.dart';
import 'package:harvestx/features/home/screens/seller/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/common/background.dart';
import '../../../core/common/loder.dart';
import '../../../core/constants/shared_pref.dart';
import '../../../core/constants/ui_constants.dart';
import '../../../theme/pallet.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
            password: passwordTextEditingController.text)
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
        .doc(currentUser.email) // specific user by their uid
        .get() // getting the record of user
        .then(
      (record) async // records of the user available in FIreStore assigned to the record variable
      {
        if (record.exists) {
          // If the record available
          // record exists
          if (record.data()!["isApproved"] == true) {
            // status is approved
            await sharedPreferences!.setString("uid",
                currentUser.uid); // getting data this from authentication
            await sharedPreferences!.setString("email",
                currentUser.email!); // getting data this from authentication
            await sharedPreferences!.setString(
                "name",
                record.data()![
                    "name"]); // getting data this from record i.e. form FireStore
            await sharedPreferences!.setString(
                "address",
                record.data()![
                    "address"]); // getting data this from record i.e. form FireStore
            await sharedPreferences!.setString(
                "phone",
                record.data()![
                    "phone"]); // getting data this from record i.e. form FireStore
            await sharedPreferences!
                .setString("profileImage", record.data()!["profileImage"]);
            await sharedPreferences!.setString(
                "type",
                record.data()![
                    "type"]); // getting data this from record i.e. form FireStore

            //sand user to home screen
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (c) => const NavigationFromLogin(),
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            BackgroundImage(),
            Container(
              padding: const EdgeInsets.only(left: 35, right: 35),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Hello welcome!",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Let's Login",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 70),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: TextFormField(
                        controller: emailTextEditingController,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(
                            EvaIcons.emailOutline,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: TextField(
                        controller: passwordTextEditingController,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(
                            EvaIcons.lockOutline,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 45),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(200, 50),
                          primary: Pallete.greenSecondary,
                          shape: RoundedRectangleBorder(
                            side:
                                const BorderSide(color: Pallete.greenSecondary),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: formValidation,
                        child: const Text(
                          "Log in",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'You do not have an account?',
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                          children: [
                            TextSpan(
                              text: '  Register Now',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.pushNamed(
                                    context, '/register_screen'),
                              style: const TextStyle(
                                fontSize: 15,
                                color: Pallete.primaryGreen,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
