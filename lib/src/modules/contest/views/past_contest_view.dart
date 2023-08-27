import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../modules.dart';

class PastContestView extends GetView<ContestController> {
  const PastContestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Past Contest'),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              if (controller.completedContestList.isEmpty)
                NoDataFound(
                  label: 'No Past Contest!',
                ),
              if (controller.completedContestList.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.completedContestList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CompletedContestCard(
                      contestDetails: controller.completedContestList[index],
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
