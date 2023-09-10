import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/data/data.dart';
import 'package:stoxhero/src/modules/modules.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../core/core.dart';

// class AppTutorialView extends StatefulWidget {
//   const AppTutorialView({Key? key,}) : super(key: key);

//   @override
//   _AppTutorialViewState createState() => _AppTutorialViewState();
// }

// class _AppTutorialViewState extends State<AppTutorialView> {
//   final CategoryVideos? tutorial;

//   final videoUrl = 'https://youtu.be/aqh95E7DbXo?si=rOWabRDYOXxoq1vy';
//   late YoutubePlayerController _controller;
//   late TutorialController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = Get.find<TutorialController>();
//     final videoID = YoutubePlayer.convertUrlToId(videoUrl);
//     _controller = YoutubePlayerController(
//       initialVideoId: videoID!,
//       flags: YoutubePlayerFlags(
//         autoPlay: false,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CommonCard(
//       margin: EdgeInsets.zero,
//       // padding: EdgeInsets.zero,
//       children: [
//         Column(
//           children: [
//             YoutubePlayer(
//               controller: _controller,
//             ),
//             SizedBox(height: 12),
//             Text(
//               tutorial.,
//               style: Theme.of(context).textTheme.tsMedium18,
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

class AppTutorialCard extends StatelessWidget {
  final Tutorials? tutorial;

  const AppTutorialCard({Key? key, this.tutorial}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: CommonCard(
        margin: EdgeInsets.zero,
        // padding: EdgeInsets.zero,
        children: [
          Column(
            children: [
              // YoutubePlayer(
              //   controller: _controller,
              // ),
              SizedBox(height: 12),
              Text(
                '${tutorial?.categoryName}',
                style: Theme.of(context).textTheme.tsMedium18,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
