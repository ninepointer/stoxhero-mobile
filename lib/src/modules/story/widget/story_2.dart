import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stoxhero/src/app/app.dart';

class Story2 extends StatefulWidget {
  const Story2({Key? key}) : super(key: key);

  @override
  _Story2State createState() => _Story2State();
}

class _Story2State extends State<Story2> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 2200),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background image with entrance animation
          Positioned.fill(
          child: Opacity(
            opacity: 0.55, // Adjusting opacity to 0.85
            child: Image.asset(
              AppImages.wankhede,
              fit: BoxFit.cover,
            ),
          ),
        ),
          // Content with animations
          SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                // padding: EdgeInsets.all(24.0),
                child: Center(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Container(
                          // padding: EdgeInsets.all(16.0),
                          // decoration: BoxDecoration(
                          //   border: Border.all(
                          //     color: Colors.white,
                          //     width: 2.0,
                          //   ),
                          //   borderRadius: BorderRadius.circular(16.0),
                          // ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Animate(
                                    effects: [
                                      FadeEffect(),
                                      SlideEffect(
                                          duration:
                                              Duration(milliseconds: 2200))
                                    ],
                                    child: Text(
                                      "30000+",
                                      style: TextStyle(
                                        fontSize: 60.0,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Sans-serif',
                                        color: AppColors.brandYellow,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 5.0,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    )),
                                SizedBox(height: 16.0),
                                Text(
                                  "Community of traders",
                                  style: TextStyle(
                                    fontSize: 32.0,
                                    fontFamily: 'Sans-serif',
                                    color: AppColors.lightGreen,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 5.0,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ).animate().tint(color: Colors.white),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Enough to fill Wankhede Cricket Stadium in full capacity.",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'Sans-serif',
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 5.0,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ).animate().tint(color: Colors.white),
                                SizedBox(
                                  height: 10,
                                ),
                                // Container(
                                //     // height: ,
                                //     width: double.infinity,
                                //     decoration: BoxDecoration(
                                //       // color: AppColors.white,
                                //       shape: BoxShape.rectangle,
                                //       border: Border.all(
                                //         color: AppColors.grey.withOpacity(.25),
                                //       ),
                                //     ),
                                //     child: Padding(
                                //         padding: EdgeInsets.all(0),
                                //         child: Image.asset(
                                //           AppImages.wankhede,
                                //           fit: BoxFit.cover,
                                //         )))
                              ]),
                        ),
                      );
                    },
                  ),
                ),
              ),
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
