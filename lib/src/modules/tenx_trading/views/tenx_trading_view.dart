import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../modules.dart';

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

  Widget buildInfoCard() {
    return Expanded(
      child: Card(
        elevation: 0,
        margin: EdgeInsets.only(top: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.grey.shade400,
                    ),
                    child: Icon(
                      Icons.trending_up_rounded,
                      size: 20,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NIFTY 50',
                        style: AppStyles.tsGreyMedium10,
                      ),
                      SizedBox(height: 2),
                      Text(
                        '₹ 12,500.90',
                        style: AppStyles.tsWhiteSemiBold14,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Today',
                    style: AppStyles.tsGreyRegular12,
                  ),
                  Spacer(),
                  Text(
                    '₹ 125.87',
                    style: Theme.of(context).textTheme.tsMedium12,
                  ),
                  SizedBox(width: 4),
                  Text(
                    '(+ 0.25%)',
                    style: Theme.of(context).textTheme.tsMedium12.copyWith(
                          color: AppColors.success,
                        ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
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
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 8),
                //   child: Row(
                //     children: [
                //       buildInfoCard(),
                //       SizedBox(width: 8),
                //       buildInfoCard(),
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 8),
                //   child: Row(
                //     children: [
                //       buildInfoCard(),
                //       SizedBox(width: 8),
                //       buildInfoCard(),
                //     ],
                //   ),
                // )
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
