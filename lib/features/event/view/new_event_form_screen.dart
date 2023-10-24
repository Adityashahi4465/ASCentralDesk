import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../routes/route_utils.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_style.dart';

class NewEventFormScreen extends ConsumerStatefulWidget {
  const NewEventFormScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewEventFormScreenState();
}

class _NewEventFormScreenState extends ConsumerState<NewEventFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Event',
          style: AppTextStyle.displayBlack.copyWith(
            color: AppColors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: AppColors.black,
            size: 30,
          ),
          onPressed: () => Navigation.navigateToBack(context),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Text('Evnet'),
      ),
    );
  }
}
