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
        () => RefreshIndicator(
          onRefresh: controller.loadIntershipData,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(16).copyWith(
              bottom: 100,
            ),
            child: Visibility(
              visible: controller.isInternshipLoadingStatus,
              child: Column(
                children: [
                  SmallCardShimmer(),
                  MediumCardShimmer(),
                  CustomCardShimmer(),
                  CustomCardShimmer(),
                  CustomCardShimmer(),
                ],
              ),
              replacement: Visibility(
                visible: controller.isParticipated(),
                child: Column(
                  children: [
                    CommonCard(
                      margin: EdgeInsets.zero,
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
                    InternshipInfoCard(),
                  ],
                ),
                replacement: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: Get.find<CareerController>().careerList.length,
                  itemBuilder: (context, index) {
                    if (Get.find<CareerController>().careerList[index].listingType == 'Job') {
                      return InfoCard(
                        career: Get.find<CareerController>().careerList[index],
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
