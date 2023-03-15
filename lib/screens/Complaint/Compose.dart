// ignore_for_file: use_build_context_synchronously, library_prefixes

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../global_widgets/loding_dialog.dart';
import '../../models/ComplaintFile.dart';
import '../../models/complaints_class.dart';
import 'package:path/path.dart' as path;
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;

import '../../widgets/dropdown.dart';

MailContent? complaint;
String selectedCategory = "";
final formKey1 = GlobalKey<FormState>();

class BackgroundMaker extends StatelessWidget {
  const BackgroundMaker({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: (4.3 * MediaQuery.of(context).size.width) / 8,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            ClipPath(
                clipper: CurveClipper(),
                child: Container(
                  constraints: const BoxConstraints.expand(),
                  color: const Color(0xFF181D3D),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 25.0, 0.0, 0.0),
                      child: Row(
                        children: <Widget>[
                          const SizedBox(height: 30.0),
                          CircleAvatar(
                            backgroundImage:
                                const AssetImage('assets/images/splash.png'),
                            radius: (32 * MediaQuery.of(context).size.height) /
                                1000,
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'ASComplaint',
                            style: TextStyle(
                                fontFamily: 'Amaranth',
                                color: Colors.white,
                                fontSize:
                                    (30 * MediaQuery.of(context).size.height) /
                                        1000),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 28),
                    Text('File a Complaint',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                (30 * MediaQuery.of(context).size.height) /
                                    1000)),
                    //SizedBox(height: MediaQuery.of(context).size.height / 12),
                  ]),
                )),
          ],
        ));
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      // set the "current point"
      ..lineTo(0, size.width / 8)
      ..addArc(
          Rect.fromLTWH(0, size.width / 512 - size.width / 8, size.width / 2,
              size.width / 2),
          pi,
          -pi / 2)
      ..lineTo(4 * size.width / 4, size.width / 2 - size.width / 8)
      ..addArc(
          Rect.fromLTWH(2 * size.width / 4, size.width / 2 - size.width / 8,
              size.width / 2, size.width / 2),
          3.14 + 1.57,
          1.57)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..lineTo(0, size.width / 8);
    return path;
  }

  @override
  bool shouldReclip(oldClipper) => false;
}

class ImageShow extends StatelessWidget {
  final String name;
  final VoidCallback delete;
  const ImageShow({super.key, required this.name, required this.delete});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (3.5 * MediaQuery.of(context).size.width) / 6,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.only(left: 5.0),
      color: Colors.grey[300],
      child: Row(
        children: <Widget>[
          const Icon(Icons.image),
          const SizedBox(
            width: 3.0,
          ),
          Text(name),
          //SizedBox(width: 3.0,),
          const Spacer(),
          IconButton(
            padding: const EdgeInsets.only(right: 2.0),
            onPressed: delete,
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}

class Compose extends StatefulWidget {
  const Compose({super.key});

  @override
  _ComposeState createState() => _ComposeState();
}

class _ComposeState extends State<Compose> {
  @override
  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(categories);
    //selectedItem = _dropdownMenuItems[0].value;
  }

  List<DropdownMenuItem<String>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<String>> items = [];
    for (var listItem in listItems) {
      items.add(
        DropdownMenuItem(
          value: listItem,
          child: Text(listItem),
        ),
      );
    }
    return items;
  }

  late List<DropdownMenuItem<String>> _dropdownMenuItems;
  late XFile _image;
  late String _uploadedFileURL;
  final ImagePicker imagePicker = ImagePicker();

  List<String> imagesInComplaint = [];

  pickImage(ImageSource source) async {
    _image = (await imagePicker.pickImage(source: source))!;
    setState(() {
      _image;
    });
  }

  Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    fStorage.Reference storeRef = fStorage.FirebaseStorage.instance
        .ref()
        .child(
            "'complaintImages/${path.basename(_image.path)}}'") // This folder will be created
        .child(fileName); // save in the folder with this fileName
    fStorage.UploadTask uploadImageTask =
        storeRef.putFile(File(_image.path)); // Uploading image
    print('uploaded');
    fStorage.TaskSnapshot taskSnapshot =
        await uploadImageTask.whenComplete(() {});
    await taskSnapshot.ref.getDownloadURL().then((imageUrl) {
      // taskSnapshot we got the imageUrl
      _uploadedFileURL = imageUrl;
    });
  }

  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF181D3D),
      child: SafeArea(
        child: Scaffold(
            body: Form(
          key: formKey1,
          child: ListView(
            children: <Widget>[
              const BackgroundMaker(),
              Card(
                //shadowColor: Color.fromRGBO(24, 29, 61,1),
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                elevation: 10.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //CategoryDropdown(),
                    Container(
                      //width: 0.65*MediaQuery.of(context).size.width,
                      height: 75.0,
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: DropdownButtonFormField<String>(
                            //key: formKey1,
                            hint: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 11),
                              child: const Text(
                                'Category',
                                style: TextStyle(
                                    color: Color.fromRGBO(24, 51, 98, 1),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            validator: (value) => value == null
                                ? "Please select a category"
                                : null,
                            isExpanded: true,
                            elevation: 10,
                            value: selectedCategory == ""
                                ? null
                                : selectedCategory,
                            items: _dropdownMenuItems,
                            onChanged: (value) {
                              setState(() {
                                selectedCategory = value!;
                              });
                            }),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      width: 400.0,
                      constraints: const BoxConstraints(
                        maxHeight: 200.0,
                        minHeight: 80.0,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.5),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Title can't be left empty.";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              title = value;
                            });
                          },
                          //controller: titleController,
                          minLines: 1,
                          maxLines: 3,
                          maxLength: 80,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                            height: 2.0,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Title:  ',
                            alignLabelWithHint: true,
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(24, 51, 98, 1),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      width: 400.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.8),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Description can't be left empty.";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              description = value;
                            });
                          },
                          //controller: descripController,
                          minLines: 1,
                          maxLines: 12,
                          maxLength: 350,
                          textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                            height: 2.0,
                          ),
                          decoration: const InputDecoration(
                            isDense: true,
                            labelText: 'Description:  ',
                            alignLabelWithHint: true,
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(24, 51, 98, 1),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          alignment: Alignment.centerLeft,
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: Color.fromRGBO(24, 29, 61, 1),
                            size: 40.0,
                          ),
                          color: Colors.blue,
                          onPressed: () async {
                            await pickImage(ImageSource.gallery);
                            if (_image != null) {
                              await uploadFile();
                              setState(() {
                                imagesInComplaint.add(_uploadedFileURL);
                                //print(_uploadedFileURL);
                                //print(imagesInComplaint);
                              });
                            }
                          },
                        ),
                        const Text(
                          ':   ',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30.0),
                        ),
                        Column(
                          children: imagesInComplaint
                              .map((imag) => ImageShow(
                                  name:
                                      'Uploaded Image ${imagesInComplaint.indexOf(imag)}',
                                  delete: () {
                                    setState(() {
                                      imagesInComplaint.remove(imag);
                                    });
                                  }))
                              .toList(),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey1.currentState!.validate()) {
                      print(formKey1.currentState!.validate().toString());
                      showDialog(
                          context: context,
                          builder: (c) {
                            return const LoadingDialogWidget(
                              message: "Submitting your Complaint",
                            );
                          });
                      complaint = MailContent(
                        title: title,
                        category: selectedCategory,
                        description: description,
                        images: imagesInComplaint,
                        filingTime: DateTime.now(),
                        status: status[0],
                        upvotes: [],
                        uid: FirebaseAuth.instance.currentUser!.uid,
                        email: FirebaseAuth.instance.currentUser!.email,
                      );
                      /*await Future.delayed(Duration(seconds: 2),(){

                        });*/
                      //TODO: Add mail to database.
                      title = '';
                      description = '';
                      selectedCategory = "";

                      await ComplaintFiling().fileComplaint(
                        complaint!.title,
                        complaint!.category,
                        complaint!.description,
                        0,
                        '',
                        complaint!.images,
                        complaint!.filingTime,
                        complaint!.status,
                        complaint!.upvotes,
                        complaint!.uid,
                        complaint!.email,
                      );
                      imagesInComplaint.clear();

                      /*showDialog(
                              context: context,
                              builder: (BuildContext context) => AdminDialog('SCvnnfBP66JpkhBK12do')
                            );*/
                      Navigator.pop(context);
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        text: 'Complaint Filed Successfully!',
                      );
                    } else {
                      print('yes');
                    }
                  },
                  child: const Text(
                    'Submit',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const SizedBox(
                height: 120.0,
                width: 120.0,
                child: Image(image: AssetImage('assets/images/splash.png')),
              )
            ],
          ),
        )),
      ),
    );
  }
}
