import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../palatte.dart';

class NotificationDetailsScreen extends StatelessWidget {
  final String postedBy;
  final String campus;
  final String eligibilityCriteria;
  final String description;
  final DateTime endDate;
  final DateTime postedAt;
  final String priority;
  final DateTime startDate;
  final String subtitle;
  final String title;
  final String type;
  final String venueType;

  NotificationDetailsScreen({
    required this.postedBy,
    required this.campus,
    required this.eligibilityCriteria,
    required this.description,
    required this.endDate,
    required this.postedAt,
    required this.priority,
    required this.startDate,
    required this.subtitle,
    required this.title,
    required this.type,
    required this.venueType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 198, 198, 213),
      appBar: AppBar(
        backgroundColor: violet,
        title: const Text(
          'Notification Details',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Icon(
                    Icons.person,
                    size: 18.0,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    'Posted by: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    postedBy,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Icon(
                    Icons.school,
                    size: 18.0,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    'Campus: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    campus,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 18.0,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    'Eligibility Criteria: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    eligibilityCriteria,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                'Description:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Start Date:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          '${DateFormat.yMMMMd().format(startDate)}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'End Date:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          '${DateFormat.yMMMMd().format(endDate)}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Priority:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          priority,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Posted At:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          '${DateFormat.yMMMMd().format(postedAt)}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Type:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          type,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Venue Type:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          venueType,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
