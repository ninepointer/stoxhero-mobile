import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../modules.dart';

class AppTutorialCard extends StatefulWidget {
  final TutorialList? tutorial;

  AppTutorialCard({Key? key, this.tutorial}) : super(key: key);

  @override
  _AppTutorialCardState createState() => _AppTutorialCardState();
}

class _AppTutorialCardState extends State<AppTutorialCard> {
  late TutorialController controller;

  late List<YoutubePlayerController> _controllers;

  @override
  void initState() {
    super.initState();
    controller = Get.find<TutorialController>();
    _controllers = List.generate(
      widget.tutorial?.categoryVideos?.length ?? 0,
      (index) => YoutubePlayerController(
        initialVideoId: widget.tutorial?.categoryVideos?[index].videoId ?? '',
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: !controller.isLoadingStatus,
        replacement: CommonLoader(),
        child: ListView.builder(
          itemCount: _controllers.length,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            return CommonCard(
              children: [
                YoutubePlayer(
                  controller: _controllers[index],
                  aspectRatio: 16 / 9,
                ),
                SizedBox(height: 12),
                Center(
                  child: Text(
                    '${widget.tutorial?.categoryVideos?[index].title}',
                    style: Theme.of(context).textTheme.tsMedium16,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
