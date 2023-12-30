import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';

class Story1 extends StatefulWidget {
  const Story1({Key? key}) : super(key: key);

  @override
  _Story1State createState() => _Story1State();
}

class _Story1State extends State<Story1> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _parallaxAnimation;

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

    _rotationAnimation = Tween<double>(begin: -0.2, end: 0.0).animate(
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

    _parallaxAnimation = Tween<double>(begin: 0.0, end: 50.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.4, 0.8, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 31, 65),
      body: Center(
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(24, 0, 24, 80),
            child: Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0.0, _parallaxAnimation.value),
                    child: Transform.rotate(
                      angle: _rotationAnimation.value,
                      child: Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(AppImages.lightAppName),
                                SizedBox(height: 20),
                                Text(
                                  "We Started out in May, 2023",
                                  style: TextStyle(
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Sans-serif",
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10.0,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 24.0),
                                Text(
                                  "Together we walked 🚶, we sprinted 🏃, we ran 🏃‍♂️, and we flew ✈️.",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10.0,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
