import 'package:flutter/material.dart';

import '../../../app/app.dart';

class TenxTradingView extends StatefulWidget {
  const TenxTradingView({super.key});

  @override
  State<TenxTradingView> createState() => _TenxTradingViewState();
}

class _TenxTradingViewState extends State<TenxTradingView> {
  late TenxTradingController controller;

  bool isExpanded = false;

  @override
  void initState() {
    controller = Get.find<TenxTradingController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: !controller.isLoadingStatus,
        replacement: CommonLoader(),
        child: RefreshIndicator(
          onRefresh: controller.loadData,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CommonCard(
                  onTap: () => setState(() => isExpanded = !isExpanded),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'What is TenX Trading / TenX ट्रेडिंग क्या है?',
                          style: AppStyles.tsSecondaryRegular16,
                        ),
                        Icon(
                          isExpanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                          color: AppColors.grey,
                        ),
                      ],
                    ),
                    if (isExpanded)
                      Column(
                        children: [
                          SizedBox(height: 16),
                          Text(
                            AppData.tenxInfoEnglish,
                            style: Theme.of(context).textTheme.tsRegular14,
                          ),
                          SizedBox(height: 16),
                          Text(
                            AppData.tenxInfoHindi,
                            style: Theme.of(context).textTheme.tsRegular14,
                          ),
                        ],
                      ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.tenxActiveSub.length,
                  itemBuilder: (context, index) {
                    var sub = controller.tenxActiveSub[index];
                    return Obx(
                      () => TenxTradingSubscriptionCard(
                        subscription: sub,
                        isActive: controller.userSubscriptionsIds.contains(sub.sId),
                      ),
                    );
                  },
                ),
                SizedBox(height: 36),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
