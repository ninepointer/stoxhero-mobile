import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/data/data.dart';
import 'package:stoxhero/src/modules/modules.dart';

import '../../../core/core.dart';

class ViewCard extends StatefulWidget {
  final UpcomingMarginX? viewMarginx;
  final CompletedMarginX? completedMarginx;

  ViewCard({
    Key? key,
    this.viewMarginx,
    this.completedMarginx,
  }) : super(key: key);

  @override
  State<ViewCard> createState() => _ViewCardState();
}

class _ViewCardState extends State<ViewCard> {
  late MarginXController controller;
  bool isExpanded = false;

  @override
  void initState() {
    controller = Get.find<MarginXController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isUpcoming = widget.viewMarginx != null;

    return Scaffold(
      appBar: AppBar(
        title: Text('View'),
      ),
      body: Obx(
        () => Visibility(
          visible: !controller.isLoadingStatus,
          replacement: CommonLoader(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CommonCard(
                  onTap: () => setState(() => isExpanded = !isExpanded),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Introducing MarginX',
                            style: AppStyles.tsSecondaryRegular16,
                          ),
                        ),
                        Icon(
                          isExpanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                          color: AppColors.grey,
                        ),
                      ],
                    ),
                    if (isExpanded)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          Text(
                            "We've designed this innovative trading experience to bridge the gap between learning and real-world trading, allowing you to get as close to the market as possible.",
                            style: Theme.of(context).textTheme.tsRegular14,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "What is MarginX?",
                            style: Theme.of(context).textTheme.tsMedium16,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "In MarginX, you won't just learn about trading; you'll experience it. MarginX is designed to bridge the gap between learning and real-world trading, allowing you to get as close to the market as possible & also continue to make real profit using virtual currency. Your success in MarginX depends on your ability to make informed decisions, manage risk, and seize opportunities – just like in the real trading world.",
                            style: Theme.of(context).textTheme.tsRegular14,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Here's how it works:",
                            style: Theme.of(context).textTheme.tsMedium16,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Profit on Your Investment: Just like real options trading, you'll make a profit on the amount you've invested. Let's say you've invested Rs. 100. If you grow your trading capital by 10%, your real profit will also be 10% of your invested amount, which is Rs. 10. So your final amount will be Rs. 100 (your invested amount) + Rs. 10 (profit earned), making the total Rs. 110.",
                            style: Theme.of(context).textTheme.tsRegular14,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Safety Net: If you end up with the same capital, your entire invested amount is safe",
                            style: Theme.of(context).textTheme.tsMedium16,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Proportional Loss: If your capital reduces by 10%, your real loss will also be in the same proportion, i.e., Rs. 10. So your final amount will be Rs. 100 (your invested amount) - Rs. 10 (loss made), making the total Rs. 90",
                            style: Theme.of(context).textTheme.tsRegular14,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "When will I receive my profit in my wallet?",
                            style: Theme.of(context).textTheme.tsMedium16,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "You recieve the payout in your wallet as soon as the market closes for that day i.e after 3:30 PM",
                            style: Theme.of(context).textTheme.tsRegular14,
                          ),
                        ],
                      ),
                  ],
                ),
                CommonCard(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              isUpcoming
                                  ? widget.viewMarginx?.marginXName ?? ''
                                  : widget.completedMarginx?.marginxName ?? '',
                              style: AppStyles.tsSecondaryMedium16,
                              textAlign: TextAlign.center,
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
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total Seats',
                                      style: AppStyles.tsGreyRegular12,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '${isUpcoming ? widget.viewMarginx?.maxParticipants : widget.completedMarginx?.maxParticipants}',
                                      style: Theme.of(context).textTheme.tsMedium14,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Available Seats',
                                      style: AppStyles.tsGreyRegular12,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "00",
                                      style: Theme.of(context).textTheme.tsMedium14,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Start Date & Time',
                                    style: AppStyles.tsGreyRegular12,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    FormatHelper.formatDateTimeToIST(
                                      isUpcoming
                                          ? widget.viewMarginx?.startTime
                                          : widget.completedMarginx?.startTime,
                                    ),
                                    style: Theme.of(context).textTheme.tsMedium14,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'End Date & Time',
                                    style: AppStyles.tsGreyRegular12,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    FormatHelper.formatDateTimeToIST(
                                      isUpcoming
                                          ? widget.viewMarginx?.endTime
                                          : widget.completedMarginx?.endTime,
                                    ),
                                    style: Theme.of(context).textTheme.tsMedium14,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Investment',
                                    style: AppStyles.tsGreyRegular12,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    FormatHelper.formatNumbers(
                                        isUpcoming
                                            ? widget.viewMarginx?.marginXTemplate?.entryFee
                                            : widget.completedMarginx?.entryFee,
                                        decimal: 0),
                                    style: Theme.of(context).textTheme.tsMedium14,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Portfolio',
                                    style: AppStyles.tsGreyRegular12,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    FormatHelper.formatNumbers(
                                        isUpcoming
                                            ? widget.viewMarginx?.marginXTemplate?.portfolioValue
                                            : widget.completedMarginx?.portfolioValue,
                                        decimal: 0),
                                    style: Theme.of(context).textTheme.tsMedium14,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          if (!isUpcoming)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Payout',
                                      style: AppStyles.tsGreyRegular12,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      FormatHelper.formatNumbers(
                                        widget.completedMarginx?.earning,
                                      ),
                                      style: Theme.of(context).textTheme.tsMedium14,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Payout %',
                                      style: AppStyles.tsGreyRegular12,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      controller.calculatePayout().toStringAsFixed(2),
                                      style: Theme.of(context).textTheme.tsMedium14,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          if (!isUpcoming) SizedBox(height: 16),
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
                                color: AppColors.success.withOpacity(0.25),
                              ),
                              child: Text(
                                'Buy',
                                style: AppStyles.tsWhiteMedium14.copyWith(
                                  color: AppColors.success,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.secondary.withOpacity(.25),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Share',
                                style: AppStyles.tsWhiteMedium14.copyWith(
                                  color: AppColors.secondary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
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
