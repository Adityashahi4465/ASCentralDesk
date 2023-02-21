import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final controllerEmail = TextEditingController();
  final controllerName = TextEditingController();
  final controllerSubject = TextEditingController();
  final controllerMessage = TextEditingController();

  formValidation() async {
    // password id equal to confirm password

    // check email , password , confirm Password& name text fields
    if (controllerName.text.isNotEmpty) {
      if (controllerEmail.text.isNotEmpty) {
        if (controllerSubject.text.isNotEmpty) {
          if (controllerMessage.text.isNotEmpty) {
            sendEmail(
              name: controllerName.text,
              email: controllerEmail.text,
              subject: controllerSubject.text,
              message: controllerMessage.text,
            );
          } else {
            Fluttertoast.showToast(
                msg: "Please Enter Your Message",
                toastLength: Toast.LENGTH_LONG);
          }
        } else {
          Fluttertoast.showToast(
              msg: "Please Enter Your Subject", toastLength: Toast.LENGTH_LONG);
        }
      } else {
        Fluttertoast.showToast(
            msg: "Please Fill Your Email", toastLength: Toast.LENGTH_LONG);
      }
    } else {
      // If Name is empty
      Fluttertoast.showToast(
          msg: "Please Fill Your Name", toastLength: Toast.LENGTH_LONG);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF181D3D),
        title: const Text('Contect Us'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildTextField(
              title: 'Name*',
              controller: controllerName,
            ),
            buildTextField(
              title: 'Email*',
              controller: controllerEmail,
            ),
            const SizedBox(
              height: 16,
            ),
            buildTextField(
              title: 'Subject*',
              controller: controllerSubject,
            ),
            const SizedBox(
              height: 16,
            ),
            buildTextField(
              title: 'Message*',
              controller: controllerMessage,
              maxLine: 8,
            ),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              onPressed: () {
                formValidation();
              },
              child: const Text(
                'Send',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    const serviceId = 'service_uyanerw';
    const tamplateId = 'template_cv84vuk';
    const userId = 'tZKAKI9RuUxskbp8Y';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'origin': 'https://localhost',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': tamplateId,
        'user_id': userId,
        'template_params': {
          'user_name': name,
          'user_email': email,
          'user_subject': subject,
          'user_message': message,
        },
      }),
    );
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Email Sent Successfully'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget buildTextField({
    required String title,
    required TextEditingController controller,
    int maxLine = 1,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            controller: controller,
            maxLines: maxLine,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ],
      );
}
