import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';
import 'package:stoxhero/src/core/themes/theme.dart';

class BatchLiveClassesView extends StatefulWidget {
  const BatchLiveClassesView({super.key});

  @override
  State<BatchLiveClassesView> createState() => _BatchLiveClassesViewState();
}

class _BatchLiveClassesViewState extends State<BatchLiveClassesView> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Join the live class on cliking the below button",
              style: Get.isDarkMode
                  ? AppStyles.tsWhiteMedium14
                  : AppStyles.tsBlackMedium14,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.0306,
            ),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lightGreen,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(
                      vertical: 12, horizontal: 24), // Button padding
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8), // Button border radius
                  ),
                ),
                child: Text("Join class")),
          ],
        ),
      ),
    );
  }
}
