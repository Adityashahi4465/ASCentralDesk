import 'package:flutter_riverpod/flutter_riverpod.dart';

// Creating this file just to access values which will be taken in app, and to avoid using of setState

final complaintRejectionReasonProvider = StateProvider<String>((ref) => "");
