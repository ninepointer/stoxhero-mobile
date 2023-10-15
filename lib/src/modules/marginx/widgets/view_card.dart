import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/app.dart';

class ViewCard extends StatefulWidget {
  final UpcomingMarginX? upcomingMarginX;
  final CompletedMarginX? completedMarginX;
  final LiveMarginX? liveMarginX;

  ViewCard({
    Key? key,
    this.upcomingMarginX,
    this.completedMarginX,
    this.liveMarginX,
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
    final isUpcoming = widget.upcomingMarginX != null;
    final isLive = widget.liveMarginX != null;
    log('Entry: ${widget.liveMarginX?.marginXTemplate?.entryFee?.toInt()}');
    log('Completed: ${widget.completedMarginX?.earning}');

    return Scaffold(
      appBar: AppBar(
        title: Text('View Details'),
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
                            style: Theme.of(context).textTheme.tsMedium14,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "In MarginX, you won't just learn about trading; you'll experience it. MarginX is designed to bridge the gap between learning and real-world trading, allowing you to get as close to the market as possible & also continue to make real profit using virtual currency. Your success in MarginX depends on your ability to make informed decisions, manage risk, and seize opportunities – just like in the real trading world.",
                            style: Theme.of(context).textTheme.tsRegular14,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Here's how it works:",
                            style: Theme.of(context).textTheme.tsMedium14,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Profit on Your Investment: Just like real options trading, you'll make a profit on the amount you've invested. Let's say you've invested Rs. 100. If you grow your trading capital by 10%, your real profit will also be 10% of your invested amount, which is Rs. 10. So your final amount will be Rs. 100 (your invested amount) + Rs. 10 (profit earned), making the total Rs. 110.",
                            style: Theme.of(context).textTheme.tsRegular14,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Safety Net: If you end up with the same capital, your entire invested amount is safe",
                            style: Theme.of(context).textTheme.tsMedium14,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Proportional Loss: If your capital reduces by 10%, your real loss will also be in the same proportion, i.e., Rs. 10. So your final amount will be Rs. 100 (your invested amount) - Rs. 10 (loss made), making the total Rs. 90",
                            style: Theme.of(context).textTheme.tsRegular14,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "When will I receive my profit in my wallet?",
                            style: Theme.of(context).textTheme.tsMedium14,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "You receive the payout in your wallet as soon as the market closes for that day i.e., after 3:30 PM",
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
                                  ? widget.upcomingMarginX?.marginXName ?? ''
                                  : (isLive
                                      ? widget.liveMarginX?.marginXName ?? ''
                                      : widget.completedMarginX?.marginxName ?? ''),
                              style: AppStyles.tsSecondaryMedium14,
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
                                      style: AppStyles.tsGreyMedium12,
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      '${isUpcoming ? widget.upcomingMarginX?.maxParticipants : (isLive ? widget.liveMarginX?.maxParticipants : widget.completedMarginX?.maxParticipants)}',
                                      style: Theme.of(context).textTheme.tsMedium12,
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
                                      style: AppStyles.tsGreyMedium12,
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "${isUpcoming ? controller.calculateSeatsLeft(
                                            widget.upcomingMarginX?.maxParticipants ?? 0,
                                            widget.upcomingMarginX?.participants?.length ?? 0,
                                          ).toString() : (isLive ? controller.calculateSeatsLeft(
                                            widget.liveMarginX?.maxParticipants ?? 0,
                                            widget.liveMarginX?.participants?.length ?? 0,
                                          ).toString() : widget.completedMarginX?.maxParticipants)}",
                                      style: Theme.of(context).textTheme.tsMedium12,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Starts',
                                    style: AppStyles.tsGreyMedium12,
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    FormatHelper.formatDateTimeToIST(
                                      isUpcoming
                                          ? widget.upcomingMarginX?.startTime
                                          : (isLive
                                              ? widget.liveMarginX?.startTime
                                              : widget.completedMarginX?.startTime),
                                    ),
                                    style: Theme.of(context).textTheme.tsMedium12,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Ends',
                                    style: AppStyles.tsGreyMedium12,
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    FormatHelper.formatDateTimeToIST(
                                      isUpcoming
                                          ? widget.upcomingMarginX?.endTime
                                          : (isLive ? widget.liveMarginX?.endTime : widget.completedMarginX?.endTime),
                                    ),
                                    style: Theme.of(context).textTheme.tsMedium12,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Investment',
                                    style: AppStyles.tsGreyMedium12,
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    FormatHelper.formatNumbers(
                                        isUpcoming
                                            ? widget.upcomingMarginX?.marginXTemplate?.entryFee
                                            : (isLive
                                                ? widget.liveMarginX?.marginXTemplate?.entryFee
                                                : widget.completedMarginX?.entryFee),
                                        decimal: 0),
                                    style: Theme.of(context).textTheme.tsMedium12,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Virtual Margin Money',
                                    style: AppStyles.tsGreyMedium12,
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    FormatHelper.formatNumbers(
                                        isUpcoming
                                            ? widget.upcomingMarginX?.marginXTemplate?.portfolioValue
                                            : (isLive
                                                ? widget.liveMarginX?.marginXTemplate?.portfolioValue
                                                : widget.completedMarginX?.portfolioValue),
                                        decimal: 0),
                                    style: Theme.of(context).textTheme.tsMedium12,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          if (!isUpcoming && !isLive)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Payout',
                                      style: AppStyles.tsGreyMedium12,
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      FormatHelper.formatNumbers(
                                        widget.completedMarginX?.earning,
                                      ),
                                      style: Theme.of(context).textTheme.tsMedium12,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Payout %',
                                      style: AppStyles.tsGreyMedium12,
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      '${controller.calculatePayout(
                                            widget.completedMarginX!.entryFee!,
                                            widget.completedMarginX!.earning!,
                                          ) > 0 ? '-' : ''}${controller.calculatePayout(
                                            widget.completedMarginX!.entryFee!,
                                            widget.completedMarginX!.earning!,
                                          ).abs().toStringAsFixed(2)} %',
                                      style: Theme.of(context).textTheme.tsMedium12,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          if (!isUpcoming && !isLive) SizedBox(height: 4),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        if (isUpcoming || isLive)
                          Expanded(
                            child: GestureDetector(
                              onTap: isLive
                                  ? () {
                                      if (controller.checkIfLivePurchased(widget.liveMarginX)) {
                                        controller.loadTradingData();
                                        controller.liveMarginX(widget.liveMarginX);
                                        Get.to(() => MarginXTradingView());
                                      } else {
                                        BottomSheetHelper.openBottomSheet(
                                          context: context,
                                          child: PurchaseItemBottomSheet(
                                            buyItemPrice: widget.liveMarginX?.marginXTemplate?.entryFee ?? 0,
                                            onSubmit: () {
                                              Get.back();
                                              var data = {
                                                "entryFee": widget.liveMarginX?.marginXTemplate?.entryFee,
                                                "marginXId": widget.liveMarginX?.id,
                                                "marginXName": widget.liveMarginX?.marginXName,
                                              };
                                              controller.purchaseMarginX(data);
                                            },
                                          ),
                                        );
                                      }
                                    }
                                  : () {
                                      if (controller.checkIfPurchased(widget.upcomingMarginX)) {
                                      } else {
                                        BottomSheetHelper.openBottomSheet(
                                          context: context,
                                          child: PurchaseItemBottomSheet(
                                            buyItemPrice: widget.upcomingMarginX?.marginXTemplate?.entryFee ?? 0,
                                            onSubmit: () {
                                              Get.back();
                                              var data = {
                                                "entryFee": widget.upcomingMarginX?.marginXTemplate?.entryFee,
                                                "marginXId": widget.upcomingMarginX?.id,
                                                "marginXName": widget.upcomingMarginX?.marginXName,
                                              };
                                              controller.purchaseMarginX(data);
                                            },
                                          ),
                                        );
                                      }
                                    },
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: AppColors.success.withOpacity(.25),
                                ),
                                child: Text(
                                  isLive
                                      ? controller.checkIfLivePurchased(widget.liveMarginX)
                                          ? 'Start Trading'
                                          : 'Pay Now'
                                      : controller.checkIfPurchased(widget.upcomingMarginX)
                                          ? 'Purchased'
                                          : 'Pay Now',
                                  style: AppStyles.tsWhiteMedium12.copyWith(
                                    color: AppColors.success,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              controller.upComingMarginX(widget.upcomingMarginX);
                              controller.getShareMarginX(true);
                              String url = 'https://stoxhero.com/marginxs';
                              Clipboard.setData(ClipboardData(text: url));
                              SnackbarHelper.showSnackbar('Share Link with your Friends');
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppColors.secondary.withOpacity(.25),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Share',
                                style: AppStyles.tsWhiteMedium12.copyWith(
                                  color: AppColors.secondary.shade600,
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
