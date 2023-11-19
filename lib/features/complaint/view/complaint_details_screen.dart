import 'package:as_central_desk/routes/route_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComplaintDetailsScreen extends ConsumerWidget {
  final String complaintId;
  const ComplaintDetailsScreen({
    Key? key,
    required this.complaintId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Text(
        complaintId,
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigation.navigateToBack(context),
      ),
      automaticallyImplyLeading: true,
    );
  }
}
