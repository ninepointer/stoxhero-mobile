import 'package:flutter/material.dart';
import '../../../app/app.dart';

class InternshipDashboardView extends StatefulWidget {
  const InternshipDashboardView({Key? key}) : super(key: key);

  @override
  State<InternshipDashboardView> createState() => _InternshipDashboardViewState();
}

class _InternshipDashboardViewState extends State<InternshipDashboardView> {
  late InternshipController controller;
  bool isExpanded = false;

  @override
  void initState() {
    controller = Get.find<InternshipController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Internship Dashboard'),
      ),
      body: Obx(
        () => Visibility(
          visible: !controller.isLoadingStatus,
          replacement: CommonLoader(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CommonCard(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  onTap: () => setState(() => isExpanded = !isExpanded),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'What is StoxHero Internship Program ?',
                          style: AppStyles.tsSecondaryRegular16,
                        ),
                        Icon(
                          isExpanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                          color: AppColors.grey,
                        ),
                      ],
                    ),
                    if (isExpanded) CommonInternshipInfo(),
                  ],
                ),
                // if (controller.userDetails.value.internshipBatch!.isNotEmpty)
                InternshipInfoCard(),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    children: [
                      CommonFilledButton(
                        label: 'Start Trading',
                        onPressed: () {
                          controller.loadTradingData();
                          Get.to(() => InternshipTradingView());
                        },
                      ),
                      SizedBox(height: 12),
                      CommonFilledButton(
                        label: 'View Orders',
                        onPressed: () {
                          controller.loadOrderData();
                          Get.to(() => InternshipOrdersView());
                        },
                      ),
                      SizedBox(height: 12),
                      CommonFilledButton(
                        label: 'View Analytics',
                        onPressed: () {
                          Get.to(() => InternshipAnalyticsView());
                          Get.find<InternshipController>().loadData();
                        },
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.careerList.length,
                  itemBuilder: (BuildContext context, index) {
                    if (controller.careerList[index].listingType == 'Job') {
                      return InfoCard(
                        career: controller.careerList[index],
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
