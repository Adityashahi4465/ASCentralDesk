import 'package:e_complaint_box/palatte.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetailsScreen extends StatelessWidget {
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

  const EventDetailsScreen({
    super.key,
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
      backgroundColor: const Color.fromARGB(248, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: violet,
        title: const Text(
          'Event Details',
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
                style: const TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: blackText),
              ),
              const SizedBox(height: 10.0),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  const Icon(
                    Icons.person,
                    size: 18.0,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 10.0),
                  const Text(
                    'Posted by: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: lightBlackText,
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
              const SizedBox(height: 10.0),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Icon(
                    Icons.school,
                    size: 18.0,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 10.0),
                  const Text(
                    'Eligible Campuses: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: lightBlackText,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Text(
                          campus,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Description:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: lightBlackText,
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: SelectableText(
                  description,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Eligibility Criteria: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: lightBlackText,
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: SelectableText(
                  eligibilityCriteria,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Starts From:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: lightBlackText,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          DateFormat.yMMMMd().format(startDate),
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: lightBlackText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'End Date:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: lightBlackText,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          DateFormat.yMMMMd().format(endDate),
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: lightBlackText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Priority:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: lightBlackText,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          priority,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: lightBlackText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Posted At:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: lightBlackText,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          DateFormat.yMMMMd().format(postedAt),
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: lightBlackText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Type:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: lightBlackText,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          type,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: lightBlackText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Venue Type:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: lightBlackText,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          venueType,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: lightBlackText,
                          ),
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
