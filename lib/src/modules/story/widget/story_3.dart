import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Story3 extends StatefulWidget {
  const Story3({Key? key}) : super(key: key);

  @override
  _Story3State createState() => _Story3State();
}

class _Story3State extends State<Story3> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 1600),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.8, curve: Curves.easeInOut),
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
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
          child: Opacity(
            opacity: 0.55, // Adjusting opacity to 0.85
            child: Image.asset(
              AppImages.srk,
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
                          Text(
                            "₹4000 Cr+",
                            style: TextStyle(
                              fontSize: 50.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.brandYellow,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          )
                              .animate()
                              .fadeIn() // uses `Animate.defaultDuration`
                              .scale() // inherits duration from fadeIn
                              .move(
                                  delay: 2000.ms,
                                  duration: 600
                                      .ms), // runs after the above w/new duration
                          // .blurXY(),
                          SizedBox(height: 10.0),
                          Text(
                            "Our options turnover",
                            style: TextStyle(
                              fontSize: 32.0,
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
                              .fadeIn(duration: 600.ms)
                              .then(delay: 200.ms) // baseline=800ms
                              .slide(),

                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Almost equivalent to Shah Rukh Khan's net worth",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
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
                              .fadeIn(duration: 600.ms)
                              .then(delay: 200.ms) // baseline=800ms
                              .slide(),

                          SizedBox(
                            height: 20,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: [
                          //     Container(
                          //         height: 120,
                          //         width: 80,
                          //         decoration: BoxDecoration(
                          //           // color: AppColors.white,
                          //           shape: BoxShape.rectangle,
                          //           border: Border.all(
                          //             color: AppColors.grey.withOpacity(.25),
                          //           ),
                          //         ),
                          //         child: Padding(
                          //             padding: EdgeInsets.all(2),
                          //             child: Image.asset(
                          //               AppImages.pathan,
                          //               fit: BoxFit.cover,
                          //             ))),
                          //     Container(
                          //         height: 120,
                          //         width: 80,
                          //         decoration: BoxDecoration(
                          //           // color: AppColors.white,
                          //           shape: BoxShape.rectangle,
                          //           border: Border.all(
                          //             color: AppColors.grey.withOpacity(.25),
                          //           ),
                          //         ),
                          //         child: Padding(
                          //             padding: EdgeInsets.all(2),
                          //             child: Image.asset(
                          //               AppImages.animal,
                          //               fit: BoxFit.cover,
                          //             ))),
                          //     Container(
                          //         height: 120,
                          //         width: 80,
                          //         decoration: BoxDecoration(
                          //           // color: AppColors.white,
                          //           shape: BoxShape.rectangle,
                          //           border: Border.all(
                          //             color: AppColors.grey.withOpacity(.25),
                          //           ),
                          //         ),
                          //         child: Padding(
                          //             padding: EdgeInsets.all(2),
                          //             child: Image.asset(
                          //               AppImages.gadar,
                          //               fit: BoxFit.cover,
                          //             )))
                          //   ],
                          // )
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
