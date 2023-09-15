import 'package:as_central_desk/features/auth/widgets/varify_email/verify_email_tab.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/color_utility.dart';
import '../widgets/top_bubbles.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          TopBubble(
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
          const VerifyEmailTab(),
        ],
      ),
    );
  }
}
