class MailContent {
  String title;
  String category;
  String description;
  List<String> images = [];
  DateTime filingTime;
  String status;
  List<String> upvotes = [];
  String uid;
  String? email;

  MailContent(
      {required this.title,
      required this.category,
      required this.description,
      required this.images,
      required this.filingTime,
      required this.status,
      required this.upvotes,
      required this.uid,
      required this.email});
}

List<String> status = ['Pending', 'In Progress', 'Rejected', 'Solved'];
