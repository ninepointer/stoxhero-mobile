import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/modules/contest/widgets/contest_leaderboard_card.dart';

import '../../../core/core.dart';
import '../../modules.dart';

class ContestLeaderboardView extends GetView<ContestController> {
  const ContestLeaderboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contests Leaderboard'),
      ),
      body: Obx(
        () => Visibility(
          visible: !controller.isLoadingStatus,
          replacement: CommonLoader(),
          child: RefreshIndicator(
            onRefresh: controller.loadData,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CommonSegmentedControl(
                    segments: {
                      0: 'StoxHero Contest',
                      1: 'College Contest',
                    },
                    selectedSegment: controller.segmentedControlValue.value,
                    onValueChanged: controller.handleSegmentChange,
                  ),
                  ContestLeaderboardCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
