import 'package:as_central_desk/features/auth/widgets/sign_in/signin_tab.dart';
import 'package:as_central_desk/features/auth/widgets/sign_up/signup_tab.dart';
import 'package:as_central_desk/constants/app_constant.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/color_utility.dart';
import '../../../core/utils/snakbar.dart';
import '../animations/auth_animations.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  AuthScreenState createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController animationController;
  late OnBoardingEnterAnimation onBoardingEnterAnimation;
  ValueNotifier<double> selectedIndex = ValueNotifier<double>(0.0);

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.8,
    );

    animationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    onBoardingEnterAnimation = OnBoardingEnterAnimation(animationController);

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Stack(
            children: [
              TopBubble(
                onBoardingEnterAnimation: onBoardingEnterAnimation,
                diameter: size.height,
                top: -size.height * 0.5,
                right: -size.width * 0.1,
                linearGradient: LinearGradient(
                  begin: FractionalOffset.bottomLeft,
                  end: FractionalOffset.topRight,
                  colors: <Color>[
                    Color(getColorHexFromStr("#EA9F57")),
                    Color(getColorHexFromStr("#DD6F85")),
                  ],
                ),
              ),
              TopBubble(
                onBoardingEnterAnimation: onBoardingEnterAnimation,
                diameter: size.width,
                top: -size.width * 0.5,
                right: size.width * 0.5,
                linearGradient: LinearGradient(
                  begin: FractionalOffset.bottomLeft,
                  end: FractionalOffset.topRight,
                  colors: <Color>[
                    Colors.white.withOpacity(0.2),
                    Colors.white.withOpacity(0.2),
                  ],
                ),
              ),
              TopBubble(
                onBoardingEnterAnimation: onBoardingEnterAnimation,
                diameter: size.width,
                top: -size.width * 0.5,
                right: -size.width * 0.7,
                linearGradient: LinearGradient(
                  begin: FractionalOffset.bottomLeft,
                  end: FractionalOffset.topRight,
                  colors: <Color>[
                    Colors.white.withOpacity(0.0),
                    Colors.white.withOpacity(0.2),
                  ],
                ),
              ),
              TopBubble(
                onBoardingEnterAnimation: onBoardingEnterAnimation,
                diameter: size.width,
                top: -size.width * 0.7,
                right: -size.width * 0.4,
                linearGradient: LinearGradient(
                  begin: FractionalOffset.bottomLeft,
                  end: FractionalOffset.topRight,
                  colors: <Color>[
                    Colors.white.withOpacity(0.0),
                    Colors.white.withOpacity(0.2),
                  ],
                ),
              ),
              TopBubble(
                onBoardingEnterAnimation: onBoardingEnterAnimation,
                diameter: size.width,
                top: -size.width * 0.7,
                right: size.width * 0.2,
                linearGradient: LinearGradient(
                  begin: FractionalOffset.bottomLeft,
                  end: FractionalOffset.topRight,
                  colors: <Color>[
                    Colors.white.withOpacity(0.0),
                    Colors.white.withOpacity(0.2),
                  ],
                ),
              ),
              TopBubble(
                onBoardingEnterAnimation: onBoardingEnterAnimation,
                diameter: size.width * 0.5,
                top: -size.width * 0.5,
                right: size.width * 0.5,
                linearGradient: LinearGradient(
                  begin: FractionalOffset.bottomLeft,
                  end: FractionalOffset.topRight,
                  colors: <Color>[
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.0),
                  ],
                ),
              ),
              TopBubble(
                onBoardingEnterAnimation: onBoardingEnterAnimation,
                diameter: size.height * 0.5,
                top: size.height * 0.5,
                right: -size.width * 0.5,
                linearGradient: LinearGradient(
                  begin: FractionalOffset.bottomLeft,
                  end: FractionalOffset.topRight,
                  colors: <Color>[
                    Color(getColorHexFromStr("#EC5A7A")),
                    Color(getColorHexFromStr("#E17D73")),
                  ],
                ),
              ),
              FadeTransition(
                opacity: onBoardingEnterAnimation.fadeTranslation,
                child: NotificationListener(
                  onNotification: (ScrollNotification notification) {
                    if (notification.depth == 0 &&
                        notification is ScrollUpdateNotification) {
                      selectedIndex.value = _pageController.page!;
                      setState(() {});
                    }
                    return false;
                  },
                  child: PageView(
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (int index) {},
                    children: <Widget>[
                      SignInTab(
                        onPressed: () {
                          showCustomSnackbar(
                            context,
                            'Please select a campus first',
                          );
                          _pageController.animateToPage(1,
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.fastOutSlowIn);
                        },
                      ),
                      SignUpTab(
                        onPressed: () {
                          showCustomSnackbar(
                            context,
                            'Please select a campus first',
                          );
                          // _pageController.animateToPage(0,
                          //     duration: const Duration(milliseconds: 1000),
                          //     curve: Curves.fastOutSlowIn);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.75,
                left: size.width * 0.1,
                child: InkWell(
                  onTap: () {},
                  child: SocialMediaAppButton(
                    onBoardingEnterAnimation: onBoardingEnterAnimation,
                    context: context,
                    color: COLOR_GOOGLE,
                    image: IMAGE_PATH_GOOGLE,
                    size: 48,
                    animatedValue: -selectedIndex.value,
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.8,
                left: size.width * 0.3,
                child: InkWell(
                  onTap: () {},
                  child: SocialMediaAppButton(
                    onBoardingEnterAnimation: onBoardingEnterAnimation,
                    context: context,
                    color: COLOR_FACEBOOK,
                    image: IMAGE_PATH_FACEBOOK,
                    size: 48,
                    animatedValue: -selectedIndex.value,
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.85,
                left: size.width * 0.5,
                child: InkWell(
                  onTap: () {},
                  child: SocialMediaAppButton(
                    onBoardingEnterAnimation: onBoardingEnterAnimation,
                    context: context,
                    color: COLOR_TWITTER,
                    image: IMAGE_PATH_TWITTER,
                    size: 48,
                    animatedValue: -selectedIndex.value,
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.05,
                left: size.width * 0.3,
                child: InkWell(
                  onTap: () {},
                  child: SocialMediaAppButton(
                    onBoardingEnterAnimation: onBoardingEnterAnimation,
                    context: context,
                    color: COLOR_GOOGLE,
                    image: IMAGE_PATH_GOOGLE,
                    size: 48,
                    animatedValue: 1 - selectedIndex.value,
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.1,
                left: size.width * 0.5,
                child: InkWell(
                  onTap: () {},
                  child: SocialMediaAppButton(
                    onBoardingEnterAnimation: onBoardingEnterAnimation,
                    context: context,
                    color: COLOR_FACEBOOK,
                    image: IMAGE_PATH_FACEBOOK,
                    size: 48,
                    animatedValue: 1 - selectedIndex.value,
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.15,
                left: size.width * 0.7,
                child: InkWell(
                  onTap: () {},
                  child: SocialMediaAppButton(
                    onBoardingEnterAnimation: onBoardingEnterAnimation,
                    context: context,
                    color: COLOR_TWITTER,
                    image: IMAGE_PATH_TWITTER,
                    size: 48,
                    animatedValue: 1 - selectedIndex.value,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class SocialMediaAppButton extends StatelessWidget {
  const SocialMediaAppButton({
    super.key,
    required this.onBoardingEnterAnimation,
    required this.context,
    required this.color,
    required this.image,
    required this.size,
    required this.animatedValue,
  });

  final OnBoardingEnterAnimation onBoardingEnterAnimation;
  final BuildContext context;
  final String color;
  final String image;
  final double size;
  final double animatedValue;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: onBoardingEnterAnimation.fadeTranslation,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.translationValues(
            animatedValue * MediaQuery.of(context).size.height, 0, 0.0),
        child: Container(
          height: size,
          width: size,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(25),
            color: Color(getColorHexFromStr(color)),
          ),
          child: Text('Google'),
        ),
      ),
    );
  }
}

class TopBubble extends StatelessWidget {
  const TopBubble({
    super.key,
    required this.onBoardingEnterAnimation,
    required this.diameter,
    required this.top,
    required this.right,
    required this.linearGradient,
  });

  final OnBoardingEnterAnimation onBoardingEnterAnimation;
  final double diameter;
  final double top;
  final double right;
  final LinearGradient linearGradient;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      child: Transform(
        transform: Matrix4.diagonal3Values(
            onBoardingEnterAnimation.scaleTranslation.value,
            onBoardingEnterAnimation.scaleTranslation.value,
            1.0),
        child: Container(
          height: diameter,
          width: diameter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(diameter / 2),
            gradient: linearGradient,
          ),
        ),
      ),
    );
  }
}
