import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Story7 extends StatelessWidget {
  const Story7({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 31, 65),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Image.asset(
          AppImages.newyearStory5,
        ).animate().scale(
              duration: Duration(milliseconds: 700),
            ),
      ),
    );
  }
}
