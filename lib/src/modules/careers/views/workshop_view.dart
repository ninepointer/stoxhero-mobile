import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/modules/careers/careers_index.dart';

import '../../../core/core.dart';

class WorkshopView extends StatefulWidget {
  const WorkshopView({Key? key}) : super(key: key);

  @override
  _WorkshopViewState createState() => _WorkshopViewState();
}

class _WorkshopViewState extends State<WorkshopView> {
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
        title: Text('Workshop'),
      ),
      body: SingleChildScrollView(
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
                      'What is StoxHero Workshop ?',
                      style: Theme.of(context).textTheme.tsMedium16,
                    ),
                    Icon(
                      isExpanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                      color: AppColors.grey,
                    ),
                  ],
                ),
                if (isExpanded) bulletPoint(),
              ],
            ),
            SizedBox(height: 8),
            CommonTile(
              label: "Registered Workshop(s)",
            ),
            CareerInfoCard(
              label: 'Basics of Options Trading: Workshop',
              isInternship: false,
              onPressed: () {},
            ),
            SizedBox(height: 12),
            CommonTile(
              label: "Attended Workshop(s)",
            ),
            CommonCard(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Basics of Options Trading: Workshop",
                          style: AppStyles.tsSecondaryMedium16,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(thickness: 1, height: 0),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Start Date & Time',
                                style: Theme.of(context).textTheme.tsRegular12,
                              ),
                              SizedBox(height: 4),
                              Text(
                                '23 Aug 2023 09:20 AM',
                                style: Theme.of(context).textTheme.tsMedium14,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'End Date & Time',
                                style: Theme.of(context).textTheme.tsRegular12,
                              ),
                              SizedBox(height: 4),
                              Text(
                                '23 Aug 2023 10:20 PM',
                                style: Theme.of(context).textTheme.tsMedium14,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                          child: Text(
                            'View Details',
                            style: AppStyles.tsWhiteMedium14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
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
                          'What is StoxHero Workshop ?',
                          style: Theme.of(context).textTheme.tsMedium16,
                        ),
                        Icon(
                          isExpanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                          color: AppColors.grey,
                        ),
                      ],
                    ),
                    if (isExpanded) bulletPoint(),
                  ],
                ),
                SizedBox(height: 8),
                // CommonTile(
                //   label: "Registered Workshop(s)",
                // ),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.careerList.length,
                  itemBuilder: (BuildContext context, index) {
                    if (controller.careerList[index].listingType == 'Workshop') {
                      return InfoCard(
                        career: controller.careerList[index],
                      );
                    } else {
                      return NoDataFound(label: 'No Workshop');
                    }
                  },
                ),

                // CommonTile(
                //   label: "Attended Workshop(s)",
                // ),
                // CommonCard(
                //   padding: EdgeInsets.zero,
                //   children: [
                //     Container(
                //       width: double.infinity,
                //       padding: EdgeInsets.all(12),
                //       alignment: Alignment.center,
                //       child: Row(
                //         children: [
                //           Expanded(
                //             child: Text(
                //               "Basics of Options Trading: Workshop",
                //               style: AppStyles.tsSecondaryMedium16,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     Divider(thickness: 1, height: 0),
                //     SizedBox(height: 8),
                //     Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 12),
                //       child: Column(
                //         children: [
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   Text(
                //                     'Start Date & Time',
                //                     style: Theme.of(context).textTheme.tsRegular12,
                //                   ),
                //                   SizedBox(height: 4),
                //                   Text(
                //                     '23 Aug 2023 09:20 AM',
                //                     style: Theme.of(context).textTheme.tsMedium14,
                //                   ),
                //                 ],
                //               ),
                //               Column(
                //                 crossAxisAlignment: CrossAxisAlignment.end,
                //                 children: [
                //                   Text(
                //                     'End Date & Time',
                //                     style: Theme.of(context).textTheme.tsRegular12,
                //                   ),
                //                   SizedBox(height: 4),
                //                   Text(
                //                     '23 Aug 2023 10:20 PM',
                //                     style: Theme.of(context).textTheme.tsMedium14,
                //                   ),
                //                 ],
                //               ),
                //             ],
                //           ),
                //           SizedBox(height: 12),
                //         ],
                //       ),
                //     ),
                //     Row(
                //       children: [
                //         Expanded(
                //           child: GestureDetector(
                //             child: Container(
                //               alignment: Alignment.center,
                //               padding: EdgeInsets.all(12),
                //               decoration: BoxDecoration(
                //                 color: AppColors.secondary,
                //                 borderRadius: BorderRadius.only(
                //                   bottomLeft: Radius.circular(8),
                //                   bottomRight: Radius.circular(8),
                //                 ),
                //               ),
                //               child: Text(
                //                 'View Details',
                //                 style: AppStyles.tsWhiteMedium14,
                //               ),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bulletPoint() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text(
          "Welcome to our Options Trading Workshop: Unleash the Power of Knowledge! This intensive workshop focuses on providing participants with a solid understanding of the basics and benefits of options trading. Whether you're a novice or an experienced trader, this workshop is designed to enhance your skills and boost your trading performance.",
          style: Theme.of(context).textTheme.tsRegular16,
        ),
        SizedBox(height: 12),
        Text(
          'Perks & Benefits of StoxHero Workshop',
          style: Theme.of(context).textTheme.tsMedium16,
        ),
        SizedBox(height: 12),
        Text(
          "1. During the workshop, you'll receive comprehensive training on the fundamentals of options trading.",
          style: Theme.of(context).textTheme.tsRegular14,
        ),
        SizedBox(height: 8),
        Text(
          "2. Our expert instructors will guide you through various strategies, risk management techniques, and market analysis methods.",
          style: Theme.of(context).textTheme.tsRegular14,
        ),
        SizedBox(height: 12),
        Text(
          "3. With access to the Stoxhero platform, you'll be able to apply your knowledge and execute trades in real-time.",
          style: Theme.of(context).textTheme.tsRegular14,
        ),
        SizedBox(height: 12),
        Text(
          "4. Gain practical experience as you navigate the platform's features, place trades, and manage positions.",
          style: Theme.of(context).textTheme.tsRegular14,
        ),
        SizedBox(height: 8),
        Text(
          "5. At the end of the trading session, your performance will be evaluated based on your profit and loss (P&L).",
          style: Theme.of(context).textTheme.tsRegular14,
        ),
        SizedBox(height: 8),
        Text(
          "6. To recognize outstanding achievements, we will award special certificates to the top three participants with the highest P&Ls.",
          style: Theme.of(context).textTheme.tsRegular14,
        ),
        SizedBox(height: 8),
        Text(
          "7. Rest of the participants will receive well-deserved participation certificates.",
          style: Theme.of(context).textTheme.tsRegular14,
        ),
      ],
    );
  }
}
