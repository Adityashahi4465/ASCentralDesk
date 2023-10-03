import 'package:as_central_desk/constants/ui_constants.dart';
import 'package:as_central_desk/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../theme/theme.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  int _page = 0;
  final PageController _pageController = PageController(initialPage: 0);

  void onPageChange(int index) {
    setState(() {
      _page = index;
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void handleLogout(WidgetRef ref) {
    // Call the logout method from the AuthController
    ref.read(authControllerProvider.notifier).logOut();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Call super build method
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChange,
        physics: const NeverScrollableScrollPhysics(), // Disable page sliding
        children: UiConstants.homeTabWidgets,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: SizedBox(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //    DashBoard
              IconButton(
                onPressed: () {
                  onPageChange(0);
                  _pageController.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                  );
                },
                icon: const Icon(
                  Icons.home,
                  size: 30,
                ),
                color:
                    _page == 0 ? AppColors.primary : AppColors.mDisabledColor,
              ),
              //    Complaints
              IconButton(
                onPressed: () {
                  onPageChange(1);
                  _pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                  );
                },
                icon: const Icon(
                  Icons.analytics,
                  size: 30,
                ),
                color:
                    _page == 1 ? AppColors.primary : AppColors.mDisabledColor,
              ),

              const SizedBox(
                width: 30,
              ),
              //      Events
              IconButton(
                onPressed: () {
                  onPageChange(2);
                  _pageController.animateToPage(
                    2,
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                  );
                },
                icon: const Icon(
                  Icons.event_note_sharp,
                  size: 30,
                ),
                color:
                    _page == 2 ? AppColors.primary : AppColors.mDisabledColor,
              ),

              //      Profile
              IconButton(
                onPressed: () {
                  onPageChange(3);
                  _pageController.animateToPage(
                    3,
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                  );
                },
                icon: const Icon(
                  Icons.person,
                  size: 30,
                ),
                color:
                    _page == 3 ? AppColors.primary : AppColors.mDisabledColor,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: AppColors.primary),
        height: 56,
        width: 56,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
