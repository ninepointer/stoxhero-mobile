import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:flutter_animate/flutter_animate.dart';

class Story71 extends StatefulWidget {
  const Story71({Key? key}) : super(key: key);

  @override
  _Story71State createState() => _Story71State();
}

class _Story71State extends State<Story71> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 1400),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.2, 1.0, curve: Curves.easeInOutBack),
      ),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 31, 65),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Opacity(
            opacity: 0.55, // Adjusting opacity to 0.85
            child: Image.asset(
              AppImages.hero,
              fit: BoxFit.cover,
            ),
          ),
          ),
          // Content with animations
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: 300.0,
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedTextKit(
                            isRepeatingAnimation: false,
                            animatedTexts: [
                              TyperAnimatedText(
                                  "You've brought us here in 2023. Here's to you. Our Champions, our Trailblazers, our Heroes",
                                  textStyle: TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.brandYellow,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10.0,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                  speed: Duration(milliseconds: 45)),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          // Text(
                          //   "We held 904 TestZone this year, saw 25,699 participations.",
                          //   style: TextStyle(
                          //     fontSize: 16.0,
                          //     color: Colors.white,
                          //     shadows: [
                          //       Shadow(
                          //         blurRadius: 10.0,
                          //         color: Colors.black,
                          //       ),
                          //     ],
                          //   ),
                          //   textAlign: TextAlign.center,
                          // )
                          //     .animate()
                          //     .fadeIn(duration: Duration(milliseconds: 3000)),
                          // SizedBox(height: 10.0),
                          // Text(
                          //   "In 49 TenX plans, we had 1211 subscriptions from you.",
                          //   style: TextStyle(
                          //     fontSize: 16.0,
                          //     color: Colors.white,
                          //     shadows: [
                          //       Shadow(
                          //         blurRadius: 10.0,
                          //         color: Colors.black,
                          //       ),
                          //     ],
                          //   ),
                          //   textAlign: TextAlign.center,
                          // )
                          //     .animate()
                          //     .fadeIn(duration: Duration(milliseconds: 3000)),
                          // SizedBox(height: 10.0),
                          // Text(
                          //   "414 MarginXs and 2021 participations",
                          //   style: TextStyle(
                          //     fontSize: 16.0,
                          //     color: Colors.white,
                          //     shadows: [
                          //       Shadow(
                          //         blurRadius: 10.0,
                          //         color: Colors.black,
                          //       ),
                          //     ],
                          //   ),
                          //   textAlign: TextAlign.center,
                          // )
                          //     .animate()
                          //     .fadeIn(duration: Duration(milliseconds: 3000)),
                          // SizedBox(height: 10.0),
                          // Text(
                          //   "And 1800 of you honed your skills in virtual F&O trading.",
                          //   style: TextStyle(
                          //     fontSize: 16.0,
                          //     color: Colors.white,
                          //     shadows: [
                          //       Shadow(
                          //         blurRadius: 10.0,
                          //         color: Colors.black,
                          //       ),
                          //     ],
                          //   ),
                          //   textAlign: TextAlign.center,
                          // )
                          //     .animate()
                          //     .fadeIn(duration: Duration(milliseconds: 3000)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
