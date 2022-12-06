// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:e_complaint_box/global/global.dart';
import 'package:e_complaint_box/global_screens/verify_email.dart';
import 'package:e_complaint_box/global_widgets/loding_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_complaint_box/palatte.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../services/connectivity_provider.dart';
import '../../widgets/widgets.dart';
import '../../../global_screens/No_internet.dart';
import 'students_login_Screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return pageUI();
  }
}

class Ui extends StatefulWidget {
  const Ui({super.key});

  @override
  State<Ui> createState() => _UiState();
}

class _UiState extends State<Ui> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController rollNoTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  var options = [
    'Student',
  ];
  var rool = "Student";
  String? hostelname;

  String downloadUrlImage = "";
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final ImagePicker imagePicker = ImagePicker();
  XFile? imgXFile;
  getImageFromGallery() async {
    imgXFile = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imgXFile;
    });
  }

  formValidation() async {
    if (imgXFile == null) {
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
          if (emailTextEditingController.text.substring(
                  emailTextEditingController.text.length - 11,
                  emailTextEditingController.text.length) ==
              '@dseu.ac.in') {
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
                storeRef.putFile(File(imgXFile!.path)); // Uploading image
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
                msg:
                    "Must include organization domain in you email address i.e.\n. @dseu.ac.in",
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
      // save the info to database and locally using SharedPreferences
      saveInfoToFirestoreAndLocally(currentUser!);
    }
  }

  saveInfoToFirestoreAndLocally(User currentUser) async {
    final database = FirebaseFirestore.instance.collection('users');
    await database.doc(currentUser.uid).set({
      'name': nameTextEditingController.text.trim(),
      'uid': currentUser.uid,
      'email': currentUser.email,
      'campus': 'Dwarka',
      'rollNo': rollNoTextEditingController.text.trim(),
      'type': rool,
      'category': "general",
      'photoUrl': downloadUrlImage,
      'list of my filed Complaints': []
    });

    // save locally because once user lodgedIn or singed up  after that we do not fetch data everytime from database
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!.setString("email", currentUser.email!);
    await sharedPreferences!
        .setString("name", nameTextEditingController.text.trim());
    await sharedPreferences!.setString("type", rool.toString());
    await sharedPreferences!.setString("photoUrl", downloadUrlImage);
    await sharedPreferences!
        .setStringList("list of my filed Complaints", ["initialValue"]);
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (c) => const VerifyEmailPage(),
      ),
    );
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
                    height: 150,
                    child: Center(
                      child: Text(
                        'E-ASComplaint',
                        style: kHeading,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // get-Capture-the-image
                  GestureDetector(
                    onTap: () {
                      getImageFromGallery();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white70,
                      radius: MediaQuery.of(context).size.width * 0.18,
                      backgroundImage: imgXFile == null
                          ? null
                          : FileImage(
                              File(imgXFile!.path),
                            ),
                      child: imgXFile == null
                          ? Icon(
                              Icons.add_photo_alternate,
                              color: Colors.black54,
                              size: MediaQuery.of(context).size.width * 0.15,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        Form(
                          key: formkey,
                          child: Column(
                            children: [
                              TextInput(
                                textEditingController:
                                    nameTextEditingController,
                                icon: FontAwesomeIcons.solidEnvelope,
                                hint: 'Name',
                                inputType: TextInputType.emailAddress,
                                inputAction: TextInputAction.next,
                              ),
                              TextInput(
                                textEditingController:
                                    rollNoTextEditingController,
                                icon: FontAwesomeIcons.solidEnvelope,
                                hint: 'Roll No',
                                inputType: TextInputType.number,
                                inputAction: TextInputAction.next,
                              ),
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
                              PasswordInput(
                                textEditingController:
                                    confirmPasswordTextEditingController,
                                icon: FontAwesomeIcons.lock,
                                hint: 'Confirm Password',
                                inputAction: TextInputAction.done,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(
                                color: Colors.black.withOpacity(0.3)),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: Container(
                                padding: EdgeInsets.symmetric(horizontal: 11),
                                child: const Text('Hostel',
                                    style: TextStyle(fontSize: 16)),
                              ),
                              value: hostelname,
                              onChanged: (newValue) {
                                setState(() {
                                  hostelname = newValue;
                                });
                              },
                              isExpanded: true,
                              style: kBodyText,
                              items: <String>[
                                'Aryabhatt DSEU Ashok Vihar Campus',
                                'Ambedkar DSEU Shakarpur Campus - I',
                                'Bhai Parmanand DSEU Shakarpur Campus - II',
                                'G.B. Pant DSEU Okhla-I Campus',
                                'DSEU Okhla-II Campus	',
                                'GB Pant DSEU Okhla-III Campus',
                                '	Guru Nanak Dev DSEU Rohini Campus',
                                'DSEU Pusa Campus',
                                'DSEU  Pusa Campus',
                                'DSEU Dwarka Campus',
                                'DSEU Siri Fort Campus',
                                'Kasturba DSEU Pitampura Campus',
                                'Meerabai DSEU Maharani Bagh Campus',
                                'DSEU Rajokri Campus',
                                'DSEU Vivek Vihar Campus',
                                'DSEU Wazirpur-I Campuss',
                                'Centre for Healthcare, Allied Medical and Paramedical Sciences',
                                'DSEU Dheerpur Campus',
                                '	DSEU Mayur Vihar Campus'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 11),
                                    child: Text(
                                      value,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(fontSize: 16),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        DropdownButton<String>(
                          dropdownColor: Colors.blue[900],
                          isDense: true,
                          isExpanded: false,
                          iconEnabledColor: Colors.white,
                          focusColor: Colors.white,
                          items: options.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(
                                dropDownStringItem,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            );
                          }).toList(),
                          value: rool,
                          onChanged: (newValueSelected) {
                            setState(() {
                              rool = newValueSelected!;
                            });
                          },
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
                                    'Sign Up',
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
                                              const StudentLoginPage()));
                                },
                                child: const Text(
                                  'Already Have Account?',
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
                  ),
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
    if (model.isOnline) {
      return model.isOnline ? const Ui() : const NoInternet();
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  });
}
