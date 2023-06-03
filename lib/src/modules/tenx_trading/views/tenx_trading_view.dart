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
          borderRadius: BorderRadius.circular(4),
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
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.netural.shade400,
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
                    style: AppStyles.tsWhiteMedium12,
                  ),
                  SizedBox(width: 4),
                  Text(
                    '(+ 0.25%)',
                    style: AppStyles.tsWhiteMedium12.copyWith(
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
                        isExpanded ? Icons.expand_more_rounded : Icons.expand_less_rounded,
                      ),
                    ],
                  ),
                  if (isExpanded)
                    Column(
                      children: [
                        SizedBox(height: 16),
                        Text(
                          AppData.tenxInfoEnglish,
                          style: AppStyles.tsWhiteRegular14,
                        ),
                        SizedBox(height: 16),
                        Text(
                          AppData.tenxInfoHindi,
                          style: AppStyles.tsWhiteRegular14,
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
                  return TenxTradingSubscriptionCard(
                    subscription: sub,
                  );
                },
              ),
              SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }
}
