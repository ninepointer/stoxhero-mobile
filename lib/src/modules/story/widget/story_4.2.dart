import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:flutter_animate/flutter_animate.dart';

class Story42 extends StatefulWidget {
  const Story42({Key? key}) : super(key: key);

  @override
  _Story41State createState() => _Story41State();
}

class _Story41State extends State<Story42> with SingleTickerProviderStateMixin {
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
              AppImages.storymarginx,
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
                          // AnimatedTextKit(
                          //   isRepeatingAnimation: false,
                          //   animatedTexts: [
                          //     TyperAnimatedText(
                          //         "You showed us a lot of love ❤️",
                          //         textStyle: TextStyle(
                          //           fontSize: 30.0,
                          //           fontWeight: FontWeight.bold,
                          //           color: Colors.red,
                          //           shadows: [
                          //             Shadow(
                          //               blurRadius: 10.0,
                          //               color: Colors.black,
                          //             ),
                          //           ],
                          //         ),
                          //         textAlign: TextAlign.center,
                          //         speed: Duration(milliseconds: 100)),
                          //   ],
                          // ),
                          // SizedBox(height: 10.0),
                          Text(
                            "2000+",
                            style: TextStyle(
                              fontSize: 60.0,
                              fontFamily: 'Sans-serif',
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
                          )
                              .animate()
                              .fadeIn(duration: Duration(milliseconds: 3000)),
                          SizedBox(height: 10.0),
                          Text(
                            "Traders learnt risk management with MarginX",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontFamily: 'Sans-serif',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          )
                              .animate()
                              .fadeIn(duration: Duration(milliseconds: 3000)),
                          SizedBox(height: 25.0),
                          Text(
                            "1800+",
                            style: TextStyle(
                              fontSize: 60.0,
                              fontFamily: 'Sans-serif',
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
                          )
                              .animate()
                              .fadeIn(duration: Duration(milliseconds: 3000)),
                          SizedBox(height: 10.0),
                          Text(
                            "Traders honed their skills with Virtual F&O",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontFamily: 'Sans-serif',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          )
                              .animate()
                              .fadeIn(duration: Duration(milliseconds: 3000)),
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
