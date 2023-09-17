import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/modules/modules.dart';

import '../../../core/core.dart';

class TutorialView extends GetView<TutorialController> {
  const TutorialView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutorials'),
      ),
      body: Obx(
        () => Visibility(
          visible: !controller.isLoadingStatus,
          replacement: CommonLoader(),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  CommonSegmentedControl(
                    segments: {
                      0: 'App Tutorial',
                      1: 'Option Trading',
                    },
                    selectedSegment: controller.segmentedControlValue.value,
                    onValueChanged: controller.handleSegmentChange,
                  ),
                  if (controller.segmentedControlValue.value == 0) ...[
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: controller.tutorialList.length,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final tutorial = controller.tutorialList[index];
                        if (tutorial.sId == controller.tutorialList[0].sId) {
                          return AppTutorialCard(tutorial: tutorial);
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  ] else if (controller.segmentedControlValue.value == 1)
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: controller.tutorialList.length,
                      itemBuilder: (context, index) {
                        final tutorial = controller.tutorialList[index];
                        if (tutorial.sId == controller.tutorialList[1].sId) {
                          return OptionTradingCard(tutorial: tutorial);
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  SizedBox(height: 24)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
