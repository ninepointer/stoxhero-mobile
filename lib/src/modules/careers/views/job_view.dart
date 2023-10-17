import 'package:flutter/material.dart';
import '../../../app/app.dart';

class JobView extends StatefulWidget {
  const JobView({Key? key}) : super(key: key);

  @override
  State<JobView> createState() => _JobViewState();
}

class _JobViewState extends State<JobView> {
  late CareerController controller;
  bool isExpanded = false;

  @override
  void initState() {
    controller = Get.find<CareerController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
      ),
      body: Obx(
        () => Visibility(
          visible: !controller.isLoadingStatus,
          replacement: CommonLoader(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: Get.find<CareerController>().careerList.length,
                    itemBuilder: (context, index) {
                      final controller = Get.find<CareerController>();
                      final jobType = controller.careerList[index].jobType;
                      if (jobType == "Full-Time") {
                        return InfoCard(
                          career: controller.careerList[index],
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
