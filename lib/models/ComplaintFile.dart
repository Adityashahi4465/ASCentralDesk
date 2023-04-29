import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintFiling {
  final CollectionReference complaints =
      FirebaseFirestore.instance.collection('complaints');
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future<void> fileComplaint(
      String title,
      String category,
      String description,
      int fund,
      String consults,
      List<String> images,
      DateTime filingTime,
      String status,
      List<String> upvotes,
      String uid,
      String? email) async {
    // Check if user has exceeded the monthly quota
    DateTime now = DateTime.now();
    int year = now.year;
    int month = now.month;
    String monthKey = "$year-$month";
    DocumentSnapshot userSnapshot =
        await users.doc(uid).get(); // Get user's document
    Map<String, dynamic>? monthlyData =
        userSnapshot.data()?['monthlyData']; // Get user's monthly data
    if (monthlyData != null &&
        monthlyData.containsKey(monthKey) &&
        monthlyData[monthKey]['complaintsFiled'] >= 3) {
      throw Exception('You have already filed 3 complaints this month.');
    }

    // File complaint and update user's monthly data
    String complaintID =
        FirebaseFirestore.instance.collection('complaints').doc().id;
    await complaints.doc(complaintID).set({
      'title': title,
      'category': category,
      'description': description,
      'fund': fund,
      'consults': consults,
      'list of Images': images,
      'filing time': filingTime,
      'status': status,
      'upvotes': upvotes,
      'uid': uid,
      'email': email
    });
    await users.doc(uid).update({
      'list of my filed Complaints': FieldValue.arrayUnion(
          [complaintID]), // Add complaint ID to user's filed complaints list
      'monthlyData.$monthKey': {
        // Update user's monthly data
        'complaintsFiled':
            FieldValue.increment(1) // Increment complaints filed count
      }
    });
  }
}
