import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventsAndNoticesScreen extends ConsumerStatefulWidget {
  const EventsAndNoticesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EventsAndNoticesScreenState();
}

class _EventsAndNoticesScreenState
    extends ConsumerState<EventsAndNoticesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('EventsAndNoticesScreen'),
    );
  }
}
