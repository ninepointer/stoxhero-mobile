import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';

class CourseVideoView extends StatefulWidget {
  final UserMyCoursesData? data;

  CourseVideoView({
    this.data,
  });

  @override
  State<CourseVideoView> createState() => _CourseVideoViewState();
}

class _CourseVideoViewState extends State<CourseVideoView>
    with SingleTickerProviderStateMixin {
  late CourseController controller;

  late VideoPlayerController _controller;
  late FlickManager flickManager;
  late TabController tabController;
  String title = "";
  double _playbackSpeed = 1.0;

  @override
  void initState() {
    super.initState();
    controller = Get.find<CourseController>();
    title = widget.data?.topics?.first.subtopics?.first.topic ?? '';
    tabController = TabController(length: 2, vsync: this);
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(
        Uri.parse(widget.data?.topics?.first.subtopics?.first.videoUrl ?? ''),
      )..initialize().then((_) {
          setState(() {});
        }),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    flickManager.dispose();
    super.dispose();
  }

  void updateVideoUrl(String url, String newTitle) {
    flickManager.handleChangeVideo(VideoPlayerController.networkUrl(
      Uri.parse(url),
    ));
    setState(() {
      title = newTitle; // Update video title
    });
  }

  void _changePlaybackSpeed(double speed) {
    setState(() {
      _playbackSpeed = speed;
    });
    flickManager.flickControlManager?.setPlaybackSpeed(speed);
  }

  // Future<bool> _onWillPop() async {
  //   (AppStorage.getCourseUserStarRating() == 0 &&
  //               AppStorage.getCourseSidForStarRating().isEmpty ||
  //           AppStorage.getCourseSidForStarRating() != widget.data?.sId)
  //       ? showDialog(
  //           context: context,
  //           builder: (context) {
  //             return Obx(
  //               () => AlertDialog(
  //                 title: Text("Rate this Course"),
  //                 content: Row(
  //                   children: List.generate(
  //                     5,
  //                     (index) {
  //                       return IconButton(
  //                         icon: Icon(
  //                           index < controller.currentRating.value
  //                               ? Icons.star
  //                               : Icons.star_border,
  //                           color: Colors.amber,
  //                         ),
  //                         onPressed: () {
  //                           controller.currentRating(index + 1);
  //                         },
  //                       );
  //                     },
  //                   ),
  //                 ),
  //                 actions: <Widget>[
  //                   TextButton(
  //                     onPressed: () {
  //                       Navigator.of(context).pop();
  //                       Navigator.of(context).pop();
  //                     },
  //                     child: Text(
  //                       'Cancel',
  //                       style: TextStyle(color: AppColors.lightGreen),
  //                     ),
  //                   ),
  //                   ElevatedButton(
  //                     onPressed: () {
  //                       Map<String, dynamic> data = {
  //                         "rating": controller.currentRating.value
  //                       };
  //                       controller.courseRatingApi(data, widget.data?.sId, () {
  //                         AppStorage.setCourseUserStarRating(1);
  //                         AppStorage.setCourseSidForStarRating(
  //                             widget.data?.sId);
  //                         Navigator.of(context).pop();
  //                       });
  //                     },
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: AppColors.lightGreen,
  //                       onPrimary: Colors.white,
  //                       padding: EdgeInsets.symmetric(
  //                           vertical: 4, horizontal: 8), // Button padding
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius:
  //                             BorderRadius.circular(8), // Button border radius
  //                       ),
  //                     ),
  //                     child: Text('Rate'),
  //                   ),
  //                 ],
  //               ),
  //             );
  //           },
  //         )
  //       : Navigator.of(context).pop();
  //   return false;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRect(
                child: OverflowBox(
                  alignment: Alignment.center,
                  child: FlickVideoPlayer(flickManager: flickManager),
                ),
              ),
            ),

            // SizedBox(
            //   height: MediaQuery.of(context).size.width * 0.0306,
            // ),
            // Slider(
            //   value: _playbackSpeed,
            //   min: 0.5,
            //   max: 2.0,
            //   divisions: 15,
            //   label: _playbackSpeed.toStringAsFixed(2),
            //   onChanged: (double value) {
            //     _changePlaybackSpeed(value);
            //   },
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.0306,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Get.isDarkMode
                        ? AppStyles.tsWhiteMedium18
                        : AppStyles.tsBlackMedium18,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.0306,
            ),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Container(
                      child: TabBar(
                        controller: tabController,
                        indicatorColor: AppColors.lightGreen,
                        tabs: [
                          Tab(
                            child: Text(
                              'Lectures',
                              style: Theme.of(context).textTheme.tsRegular16,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Tab(
                            child: Text(
                              'More',
                              style: Theme.of(context).textTheme.tsRegular16,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            UserCoursesLactures(
                              widget.data,
                              (url, title) {
                                updateVideoUrl(url,
                                    title); // Call updateVideoUrl function with selected URL
                              },
                            ),
                            UserCoursesOverView(widget.data, flickManager),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
