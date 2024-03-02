import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';

import 'package:video_player/video_player.dart';
import 'package:appinio_video_player/appinio_video_player.dart';

class CourseVideoView extends StatefulWidget {
  const CourseVideoView({super.key});

  @override
  State<CourseVideoView> createState() => _CourseVideoViewState();
}

class _CourseVideoViewState extends State<CourseVideoView> {
  late CourseController controller;
  late VideoPlayerController _controller;
  late CustomVideoPlayerController _customVideoPlayerController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<CourseController>();

    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'))
      ..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Player"),
        leading: IconButton(
          onPressed: () {
            AppStorage.getCourseUserStarRating() == 0
                ? showDialog(
                    context: context,
                    builder: (context) {
                      return Obx(
                        () => AlertDialog(
                          title: Text("Rate this video"),
                          content: Row(
                            children: List.generate(
                              5,
                              (index) {
                                return IconButton(
                                  icon: Icon(
                                    index < controller.currentRating.value
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: Colors.amber,
                                  ),
                                  onPressed: () {
                                    controller.currentRating(index + 1);
                                    // Navigator.pop(context,
                                    //     index + 1); // Pass the selected rating back
                                  },
                                );
                              },
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: AppColors.lightGreen),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                AppStorage.setCourseUserStarRating(1);
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.lightGreen,
                                onPrimary: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 8), // Button padding
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8), // Button border radius
                                ),
                              ),
                              child: Text('Send'),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              CustomVideoPlayer(
                  customVideoPlayerController: _customVideoPlayerController),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.0306,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "What is equity",
                    style: Get.isDarkMode
                        ? AppStyles.tsWhiteMedium18
                        : AppStyles.tsBlackMedium18,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("By - Rakesh kumar"),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.0306,
              ),
              Text(
                  "Equity Equity is the amount of money that a company's owner has put into it or owns. On a company's balance sheet, the difference between its liabilities and assets shows how much equity the company has. The share price or a value set by valuation experts or investors is used to figure out the equity value. This account is also called owners' equity, stockholders' equity, or shareholders' equity.What does equity mean?Equity, also called shareholders' equity or owners' equity for privately held corporations, is the amount of money given to a company's shareholders if all of its assets were sold and all of its debts were paid off. In the case of an acquisition, it is the value of the company's income minus any debts that are not part of the deal. A company's book value could also be its shareholders' equity. Equity is one of the most common ways that analysts judge a business's financial health. The value of equity is determined from the balance sheet of the company."),
            ],
          ),
        ),
      ),
    );
  }
}
