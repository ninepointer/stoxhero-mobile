import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/core/core.dart';

import '../home_index.dart';

class TenxTradingTabView extends StatefulWidget {
  const TenxTradingTabView({super.key});

  @override
  State<TenxTradingTabView> createState() => _TenxTradingTabViewState();
}

class _TenxTradingTabViewState extends State<TenxTradingTabView> {
  late HomeController controller;

  bool isExpanded = false;

  @override
  void initState() {
    controller = Get.find<HomeController>();
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
                        style: AppStyles.tsWhiteRegular16,
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
                            '''TenX is a unique program that gives every trader (beginner or experienced) an opportunity to make a profit at 0 (Zero) capital. You start trading using virtual currency of a specific value (margin money) provided by StoxHero. After 20 days of trading, if you've made a profit, we'll transfer 10% of the net profit amount to your wallet. Yes, you heard it right. You have a chance to earn real money, with virtual currency while learning & improving your trading skills. Don't miss it. Start trading now!'''),
                        SizedBox(height: 16),
                        Text(
                            '''TenX एक अनोखा कार्यक्रम है जो प्रत्येक ट्रेडर (शुरुआती या अनुभवी) को 0 (शून्य) पूंजी पर लाभ कमाने का अवसर देता है। आप स्टॉक्सहेरो द्वारा प्रदान किए गए एक विशिष्ट मूल्य (मार्जिन मनी) की आभासी मुद्रा का उपयोग करके व्यापार करना शुरू करते हैं। 20 दिनों के व्यापार के बाद, यदि आपने लाभ कमाया है, तो हम शुद्ध लाभ राशि का 10% आपके बटुए में स्थानांतरित कर देंगे। हां, आपने इसे सही सुना। आपके पास अपने व्यापारिक कौशल सीखने और सुधारने के दौरान आभासी मुद्रा के साथ वास्तविक पैसा कमाने का मौका है। इसे याद मत करो अभी ट्रेडिंग शुरू करें!''')
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
                  return CommonCard(
                    padding: EdgeInsets.zero,
                    children: [
                      TenxTradingCardHeader(
                        label: sub.planName ?? '-',
                        color: sub.planName == "Beginner"
                            ? AppColors.info
                            : sub.planName == "Intermediate"
                                ? AppColors.success
                                : sub.planName == "Pro"
                                    ? AppColors.danger
                                    : AppColors.primary,
                      ),
                      Divider(
                        thickness: 1,
                        height: 0,
                        color: AppColors.netural,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: sub.features?.length,
                        itemBuilder: (context, index) => TenxTradingCardTile(
                          label: sub.features?[index].description ?? '-',
                        ),
                      ),
                      ListTile(
                        visualDensity: VisualDensity.compact,
                        title: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '₹${sub.actualPrice}',
                                style: AppStyles.tsWhiteRegular16.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.baseline,
                                baseline: TextBaseline.alphabetic,
                                child: SizedBox(width: 8),
                              ),
                              TextSpan(
                                text: '₹${sub.discountedPrice}',
                                style: AppStyles.tsPrimaryMedium20,
                              ),
                            ],
                          ),
                        ),
                        trailing: CommonFilledButton(
                          width: 100,
                          height: 32,
                          onPressed: () {},
                          label: 'Unlock',
                        ),
                      ),
                    ],
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

class TenxTradingCardHeader extends StatelessWidget {
  final String label;
  final Color color;

  const TenxTradingCardHeader({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        color: color.withOpacity(0.1),
      ),
      child: Text(
        label,
        style: AppStyles.tsSecondaryMedium16.copyWith(
          color: color,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class TenxTradingCardTile extends StatelessWidget {
  final String label;

  const TenxTradingCardTile({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      minLeadingWidth: 0,
      visualDensity: VisualDensity.compact,
      leading: Icon(Icons.check_circle_rounded),
      title: Text(
        label,
        style: AppStyles.tsWhiteRegular14,
      ),
    );
  }
}
