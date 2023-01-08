import 'package:flutter/material.dart';

class LoadingDialogWidget extends StatelessWidget {
  final String? message;
  const LoadingDialogWidget({super.key, this.message});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 14),
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white70),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text("$message Please wait..."),
        ],
      ),
    );
  }
}
