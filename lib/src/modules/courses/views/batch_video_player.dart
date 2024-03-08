import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';

import 'package:video_player/video_player.dart';
import 'package:appinio_video_player/appinio_video_player.dart';

class CourseVideoView extends StatefulWidget {
  final UserMyCoursesData? data;
  final UserCoursesSubtopics subtopics;
  CourseVideoView(this.data, this.subtopics);

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

    _controller = VideoPlayerController.networkUrl(
        Uri.parse('${widget.subtopics.videoUrl ?? ''}'))
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
          title: Text("${widget.subtopics.topic ?? ''}"),
          leading: IconButton(
            onPressed: () {
              (AppStorage.getCourseUserStarRating() == 0 &&
                          AppStorage.getCourseSidForStarRating().isEmpty ||
                      AppStorage.getCourseSidForStarRating() !=
                          widget.data?.sId)
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
                                    },
                                  );
                                },
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(color: AppColors.lightGreen),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Map<String, dynamic> data = {
                                    "rating": controller.currentRating.value
                                  };
                                  controller.courseRatingApi(
                                      data, widget.data?.sId, () {
                                    AppStorage.setCourseUserStarRating(1);
                                    AppStorage.setCourseSidForStarRating(
                                        widget.data?.sId);
                                    Navigator.of(context).pop();
                                  });
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
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              _customVideoPlayerController
                      .videoPlayerController.value.isInitialized
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: CustomVideoPlayer(
                            customVideoPlayerController:
                                _customVideoPlayerController),
                      ),
                    )
                  : AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Center(child: CircularProgressIndicator())),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.0306,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${widget.subtopics.topic ?? ''}",
                    style: Get.isDarkMode
                        ? AppStyles.tsWhiteMedium18
                        : AppStyles.tsBlackMedium18,
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Text("By - Rakesh kumar"),
              //   ],
              // ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.0306,
              ),
              Text(""),
            ],
          ),
        ),
      ),
    );
  }
}
