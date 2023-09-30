import 'package:as_central_desk/features/auth/controller/auth_controller.dart';
import 'package:as_central_desk/theme/app_colors.dart';
import 'package:as_central_desk/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/color_utility.dart';
import '../widgets/overall_details_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void handleLogout(WidgetRef ref) {
    // Call the logout method from the AuthController
    ref.read(authControllerProvider.notifier).logOut();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final user = ref.watch(userProvider)!;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                  // color: Colors.white,
                  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 28.0,
                        backgroundImage: AssetImage('assets/images/temp.jpg'),
                      ),
                      const SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Your Name',
                            style: AppTextStyle.displayHeavy.copyWith(
                              color: Colors.black,
                              fontSize: 24.0,
                            ),
                          ),
                          Text(
                            'Subtitle/Description',
                            style: AppTextStyle.displayLight.copyWith(
                              color: Colors.grey,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: IconButton(
                      iconSize: 28,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_active,
                        color: Color.fromARGB(255, 252, 0, 134),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            OverallDetailsCard(
              cardGradient: AppColors.roundedButtonGradient,
            ),
            OverallDetailsCard(
              cardGradient: AppColors.orangeGradient,
            ),
          ],
        ),
      ),
    );
  }
}
