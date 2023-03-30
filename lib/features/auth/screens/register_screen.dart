// ignore_for_file: use_build_context_synchronously, file_names, library_prefixes
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:harvestx/features/home/screens/seller/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/common/background.dart';
import '../../../core/common/loder.dart';
import '../../../core/constants/shared_pref.dart';
import '../../../core/constants/ui_constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;

import '../../../core/utils.dart';
import '../../../theme/pallet.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  final List<String> _userTypes = [
    'Select',
    'Costumer',
    'Seller',
  ];
  String _selectedUserType = 'Select';

  String downloadUrlImage = "";
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? imgFile;
  Uint8List? imgWebFile;
  getImageFromGallery() async {
    final res = await pickImage();
    if (res != null) {
      if (kIsWeb) {
        setState(() {
          imgWebFile = res.files.first.bytes;
        });
      } else {
        setState(() {
          imgFile = File(res.files.first.path!);
        });
      }
    }
  }

  formValidation() async {
    if (kIsWeb) {
      if (imgWebFile == null) {
        Fluttertoast.showToast(msg: "Please select an image");
      } else {
        {
          // password id equal to confirm password
          if (passwordTextEditingController.text ==
              confirmPasswordTextEditingController.text) {
            // check email , password , confirm Password& name text fields
            if (nameTextEditingController.text.isNotEmpty &&
                emailTextEditingController.text.isNotEmpty &&
                passwordTextEditingController.text.isNotEmpty &&
                confirmPasswordTextEditingController.text.isNotEmpty) {
              if (_selectedUserType != _userTypes[0]) {
                showDialog(
                    context: context,
                    builder: (c) {
                      return const LoadingDialogWidget(
                        message: "Registering your account\n",
                      );
                    });

                // TODO 1. upload image to storage (DONE)
                // using time as a unique name for image Since Time whenever is pass is never can be recalled

                String fileName =
                    DateTime.now().millisecondsSinceEpoch.toString();
                fStorage.Reference storeRef = fStorage.FirebaseStorage.instance
                    .ref()
                    .child("userImages") // This folder will be created
                    .child(fileName); // save in the folder with this fileName

                fStorage.UploadTask uploadImageTask;
                if (kIsWeb) {
                  uploadImageTask = storeRef.putData(imgWebFile!);
                } else {
                  uploadImageTask =
                      storeRef.putFile(File(imgFile!.path)); // Uploading image
                }
                fStorage.TaskSnapshot taskSnapshot =
                    await uploadImageTask.whenComplete(() {});
                await taskSnapshot.ref.getDownloadURL().then((imageUrl) {
                  // taskSnapshot we got the imageUrl
                  downloadUrlImage = imageUrl;
                });

                // TODO 2. save the user info to firestore database (DONE)
                saveUserInformationToDatabase();
              } else {
                Fluttertoast.showToast(
                    msg: "Please Select Your Type",
                    toastLength: Toast.LENGTH_LONG);
              }
            } else {
              // Navigator.pop(context);
              Fluttertoast.showToast(
                  msg: "Please fill all mandatory fields",
                  toastLength: Toast.LENGTH_LONG);
            }
          } else //password is NOT equal to confirm password
          {
            Fluttertoast.showToast(
                msg: "Password dose not matched",
                toastLength: Toast.LENGTH_LONG);
          }
        }
      }
    } else if (imgFile == null) {
      // If image not selected
      Fluttertoast.showToast(msg: "Please select an image");
    } else // If image already selected
    {
      // password id equal to confirm password
      if (passwordTextEditingController.text ==
          confirmPasswordTextEditingController.text) {
        // check email , password , confirm Password& name text fields
        if (nameTextEditingController.text.isNotEmpty &&
            emailTextEditingController.text.isNotEmpty &&
            passwordTextEditingController.text.isNotEmpty &&
            confirmPasswordTextEditingController.text.isNotEmpty) {
          if (_selectedUserType != _userTypes[0]) {
            showDialog(
                context: context,
                builder: (c) {
                  return const LoadingDialogWidget(
                    message: "Registering your account",
                  );
                });

            // TODO 1. upload image to storage (DONE)
            // using time as a unique name for image Since Time whenever is pass is never can be recalled

            String fileName = DateTime.now().millisecondsSinceEpoch.toString();
            fStorage.Reference storeRef = fStorage.FirebaseStorage.instance
                .ref()
                .child("userImages") // This folder will be created
                .child(fileName); // save in the folder with this fileName
            fStorage.UploadTask uploadImageTask =
                storeRef.putFile(File(imgFile!.path)); // Uploading image
            fStorage.TaskSnapshot taskSnapshot =
                await uploadImageTask.whenComplete(() {});
            await taskSnapshot.ref.getDownloadURL().then((imageUrl) {
              // taskSnapshot we got the imageUrl
              downloadUrlImage = imageUrl;
            });

            // TODO 2. save the user info to firestore database (DONE)
            saveUserInformationToDatabase();
          } else {
            Fluttertoast.showToast(
                msg: "Please Select Your Type", toastLength: Toast.LENGTH_LONG);
          }
        } else {
          // Navigator.pop(context);
          Fluttertoast.showToast(
              msg: "Please fill all mandatory fields",
              toastLength: Toast.LENGTH_LONG);
        }
      } else //password is NOT equal to confirm password
      {
        Fluttertoast.showToast(
            msg: "Password dose not matched", toastLength: Toast.LENGTH_LONG);
      }
    }
  }

  saveUserInformationToDatabase() async {
    // Authenticating the user first
    User? currentUser;
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: emailTextEditingController.text.trim(),
      password: passwordTextEditingController.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user;
    }).catchError((errorMassage) {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "An Error Occurred: \n $errorMassage",
          toastLength: Toast.LENGTH_LONG);
    });

    if (currentUser != null) {
      // save the info to database and locally using SharedPreferences
      saveInfoToFirestoreAndLocally(currentUser!);
    }
  }

  saveInfoToFirestoreAndLocally(User currentUser) async {
    final database = FirebaseFirestore.instance.collection('users');
    await database.doc(currentUser.email).set({
      'name': nameTextEditingController.text.trim(),
      'uid': currentUser.uid,
      'email': currentUser.email,
      'type': _selectedUserType,
      'isApproved': true,
      'profileImage': downloadUrlImage,
      'phone': '',
      'address': '',
    });

    // save locally because once user lodgedIn or singed up  after that we do not fetch data everytime from database
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!.setString("email", currentUser.email!);
    await sharedPreferences!
        .setString("name", nameTextEditingController.text.trim());
    await sharedPreferences!.setString("type", _selectedUserType.toString());
    await sharedPreferences!.setString("profileImage", downloadUrlImage);

    Navigator.pop(context);
    Fluttertoast.showToast(
      msg: "Congrats's You're In \n Login To continue",
      toastLength: Toast.LENGTH_LONG,
    );

    Navigator.pushNamed(context, '/login_screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            BackgroundImage(),
            SafeArea(
              child: Container(
                padding: const EdgeInsets.only(left: 35, right: 35),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Hello welcome!",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Let's Create A New Account",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              getImageFromGallery();
                            },
                            child: imgWebFile != null
                                ? CircleAvatar(
                                    backgroundImage: MemoryImage(imgWebFile!),
                                    backgroundColor:
                                        const Color.fromARGB(179, 89, 89, 89),
                                    radius: MediaQuery.of(context).size.width *
                                        0.18,
                                  )
                                : imgFile != null
                                    ? CircleAvatar(
                                        backgroundImage: FileImage(imgFile!),
                                        backgroundColor: const Color.fromARGB(
                                            179, 89, 89, 89),
                                        radius:
                                            MediaQuery.of(context).size.width *
                                                0.18,
                                      )
                                    : CircleAvatar(
                                        backgroundColor:
                                            Color.fromARGB(97, 11, 148, 43),
                                        radius:
                                            MediaQuery.of(context).size.width *
                                                0.18,
                                        child: Icon(
                                          Icons.add_photo_alternate,
                                          color: Color.fromARGB(
                                              179, 255, 255, 255),
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                        )),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: TextFormField(
                            controller: nameTextEditingController,
                            decoration: const InputDecoration(
                              labelText: 'Enter Your Username',
                              hintText: 'Username',
                              prefixIcon: Icon(
                                EvaIcons.emailOutline,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: TextFormField(
                            controller: emailTextEditingController,
                            decoration: const InputDecoration(
                              labelText: 'Enter Your Email',
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
                          child: TextFormField(
                            controller: passwordTextEditingController,
                            decoration: const InputDecoration(
                              labelText: 'Enter Your Password',
                              hintText: 'Password',
                              prefixIcon: Icon(
                                EvaIcons.lockOutline,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: TextFormField(
                            controller: confirmPasswordTextEditingController,
                            decoration: const InputDecoration(
                              labelText: 'Confirm Your Password',
                              hintText: 'Confirm Password',
                              prefixIcon: Icon(
                                EvaIcons.lockOutline,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext builder) {
                                return Container(
                                  height: 200,
                                  child: CupertinoPicker(
                                    backgroundColor: Colors.white,
                                    itemExtent: 32,
                                    onSelectedItemChanged: (index) {
                                      setState(() {
                                        _selectedUserType = _userTypes[index];
                                      });
                                    },
                                    children: _userTypes
                                        .map((option) => Text(option))
                                        .toList(),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(137, 3, 135, 34),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  _selectedUserType,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                ),
                              ],
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
                                side: const BorderSide(
                                    color: Pallete.greenSecondary),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: formValidation,
                            child: const Text(
                              "Register",
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
                                  text: 'Already have an account?',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                  children: [
                                TextSpan(
                                  text: '  Login Now',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.pushNamed(
                                        context, '/login_screen'),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Pallete.primaryGreen,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ])),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
