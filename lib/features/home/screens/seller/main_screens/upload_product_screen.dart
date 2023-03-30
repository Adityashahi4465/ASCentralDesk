import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:harvestx/theme/pallet.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

import '../../../../../core/common/background.dart';
import '../../../../../core/constants/ui_constants.dart';
import '../../../../../core/utils.dart';

class UploadProductScreen extends StatefulWidget {
  const UploadProductScreen({Key? key}) : super(key: key);

  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  late double price;
  late int quantity;
  late String proName;
  late String proDescription;
  late String proId;
  String mainCategValue = 'select category';
  final ImagePicker _picker = ImagePicker();
  bool passwordVisible = true;
  bool processing = false;
  List<XFile> imagesFileList = [];
  List<String> imagesUrlList = [];
  dynamic _pickedImageError;

  void pickProductImages() async {
    try {
      final pickedImages = await _picker.pickMultiImage(
          maxHeight: 300, maxWidth: 300, imageQuality: 95);
      setState(() {
        imagesFileList = pickedImages;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  Widget previewImages() {
    if (imagesFileList.isNotEmpty) {
      return ListView.builder(
        itemCount: imagesFileList.length,
        itemBuilder: (context, index) {
          return Image.file(
            File(imagesFileList[index].path),
            fit: BoxFit.cover,
          );
        },
      );
    } else {
      return const Center(
        child: Text(
          'you have not \n \n picked images yet !',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      );
    }
  }

  Future<void> uploadImages() async {
    if (mainCategValue != 'select category') {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        if (imagesFileList.isNotEmpty) {
          setState(() {
            processing = true;
          });
          try {
            for (var image in imagesFileList) {
              firebase_storage.Reference ref = firebase_storage
                  .FirebaseStorage.instance
                  .ref('products/${path.basename(image.path)}');
              await ref.putFile(File(image.path)).whenComplete(() async {
                await ref.getDownloadURL().then((value) {
                  imagesUrlList.add(value);
                });
              });
            }
          } catch (e) {
            print(e);
          }
        } else {
          showSnackBar(context, 'please pick images first');
        }
      } else {
        showSnackBar(context, 'please fill all fields');
      }
    } else {
      showSnackBar(context, 'please select categories');
    }
  }

  void uploadData() async {
    if (imagesUrlList.isNotEmpty) {
      CollectionReference productRef =
          FirebaseFirestore.instance.collection('products');
      proId = const Uuid().v4();
      await productRef.doc(proId).set({
        'proId': proId,
        'maincategory': mainCategValue,
        'price': price,
        'color' : '#308493',
        'rating' : 0,
        'instock': quantity,
        'productname': proName,
        'prodescription': proDescription,
        'sid': FirebaseAuth.instance.currentUser!.email,
        'proimages': imagesUrlList,
        'discount': 0,
      }).whenComplete(() {
        setState(() {
          processing = false;
          imagesFileList = [];
          mainCategValue = 'select category';
          imagesUrlList = [];
        });
        _formKey.currentState!.reset();
      });
    } else {
      print('no images');
    }
  }

  void uploadProduct() async {
    await uploadImages().whenComplete(() => uploadData());
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              BackgroundImage(
                color: Color.fromARGB(172, 211, 214, 246),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  height: height,
                  width: width,
                  color: Color.fromARGB(77, 198, 242, 207),
                ),
              ),
              SingleChildScrollView(
                reverse: true,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            color: Color.fromARGB(115, 24, 130, 24),
                            height: width * 0.5,
                            width: width * 0.5,
                            child: imagesFileList != null
                                ? previewImages()
                                : const Center(
                                    child: Text(
                                      'you have not \n \n picked images yet !',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                          ),
                          SizedBox(
                            height: width * 0.5,
                            width: width * 0.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '* Select main category',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    DropdownButton(
                                        iconSize: 40,
                                        iconEnabledColor:
                                            Color.fromARGB(255, 12, 99, 37),
                                        dropdownColor: const Color.fromARGB(
                                            197, 10, 103, 13),
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                        value: mainCategValue,
                                        items: maincateg
                                            .map<DropdownMenuItem<String>>(
                                                (value) {
                                          return DropdownMenuItem(
                                            value: value.toLowerCase(),
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            mainCategValue = value!;
                                          });
                                        }),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                        child: Divider(
                          color: Pallete.dividerColor,
                          thickness: 1.5,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: width * 0.38,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter price';
                              } else if (value.isValidPrice() != true) {
                                return 'enter the valid price';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              price = double.parse(value!);
                            },
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: textFormDecoration.copyWith(
                              labelText: 'price',
                              hintText: 'price.. \$',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: width * 0.45,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter quantity';
                              } else if (value.isValidQuantity() != true) {
                                return 'not valid quantity';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              quantity = int.parse(value!);
                            },
                            keyboardType: TextInputType.number,
                            decoration: textFormDecoration.copyWith(
                              labelText: 'Quantity',
                              hintText: 'Add Quantity',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: width,
                          child: TextFormField(
                            maxLength: 100,
                            maxLines: 3,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter product name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              proName = value!;
                            },
                            decoration: textFormDecoration.copyWith(
                              labelText: 'Product name',
                              hintText: 'Enter product name',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: width,
                          child: TextFormField(
                            maxLines: 5,
                            maxLength: 800,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter product description';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              proDescription = value!;
                            },
                            decoration: textFormDecoration.copyWith(
                              labelText: 'product description',
                              hintText: 'Enter product description',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: FloatingActionButton(
                  onPressed: imagesFileList.isEmpty
                      ? () {
                          pickProductImages();
                        }
                      : () {
                          setState(() {
                            imagesFileList = [];
                          });
                        },
                  tooltip: imagesFileList.isEmpty
                      ? 'pick image from gallery'
                      : 'delete picked images',
                  backgroundColor: Pallete.primaryGreen,
                  child: imagesFileList.isEmpty
                      ? const Icon(
                          Icons.photo_library,
                          color: Color.fromARGB(255, 255, 255, 255),
                        )
                      : const Icon(
                          Icons.delete_forever,
                          color: Color.fromARGB(255, 255, 255, 255),
                        )),
            ),
            FloatingActionButton(
              onPressed: processing == true
                  ? null
                  : () {
                      uploadProduct();
                    },
              tooltip: 'Upload',
              backgroundColor: Pallete.primaryGreen,
              child: processing == true
                  ? const CircularProgressIndicator(
                      color: Color.fromARGB(255, 255, 255, 255),
                    )
                  : const Icon(
                      Icons.upload,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

var textFormDecoration = InputDecoration(
  labelText: 'price',
  hintText: 'price.. \$',
  labelStyle: const TextStyle(
    color: Pallete.greenSecondary,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: Pallete.greenSecondary,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(10),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: Color.fromARGB(255, 34, 241, 61),
      width: 1,
    ),
    borderRadius: BorderRadius.circular(10),
  ),
);

extension QuantityValidator on String {
  bool isValidQuantity() {
    return RegExp(r'^[1-9][0-9]*$').hasMatch(this);
  }
}

extension PriceValidator on String {
  bool isValidPrice() {
    return RegExp(r'^((([1-9][0-9]*[\.]*)||([0][\.]*))([0-9]{1,2}))$')
        .hasMatch(this);
  }
}
