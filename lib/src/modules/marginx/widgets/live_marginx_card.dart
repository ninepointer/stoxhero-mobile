import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/app.dart';

class LiveMarginxCard extends GetView<MarginXController> {
  final LiveMarginX? marginx;
  LiveMarginxCard({Key? key, this.marginx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      padding: EdgeInsets.zero,
      children: [
        Container(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    marginx?.marginXName ?? '',
                    style: AppStyles.tsSecondaryMedium14,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => MarginxInfoBottomSheet(),
                  );
                },
                icon: Icon(
                  Icons.info_outline_rounded,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Visibility(
                visible: marginx?.isNifty == true,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    'Nifty',
                    style: AppStyles.tsWhiteMedium12,
                  ),
                ),
              ),
              SizedBox(width: 4),
              Visibility(
                visible: marginx?.isBankNifty == true,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    'Bank Nifty',
                    style: AppStyles.tsWhiteMedium12,
                  ),
                ),
              ),
              SizedBox(width: 4),
              Visibility(
                visible: marginx?.isFinNifty == true,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.info,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    'Finnifty',
                    style: AppStyles.tsWhiteMedium12,
                  ),
                ),
              ),
              SizedBox(width: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.danger,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  'Day',
                  style: AppStyles.tsWhiteMedium12,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
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
                          'No. of Seats left',
                          style: AppStyles.tsGreyMedium12,
                        ),
                        SizedBox(height: 2),
                        Text(
                          controller
                              .calculateSeatsLeft(
                                marginx?.maxParticipants ?? 0,
                                marginx?.participants?.length ?? 0,
                              )
                              .toString(),
                          style: Theme.of(context).textTheme.tsMedium12,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Image.asset(
                        AppImages.contestTrophy,
                        width: 40,
                      ),
                      Text(
                        'Reward',
                        style: AppStyles.tsGreyMedium12,
                      ),
                      Text(
                        '% of your Investment',
                        style: Theme.of(context).textTheme.tsMedium12,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Remaining Time',
                          style: AppStyles.tsGreyMedium12,
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Started',
                          style: Theme.of(context).textTheme.tsMedium12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
                        FormatHelper.formatDateTimeToIST(marginx?.startTime),
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
                        FormatHelper.formatDateTimeToIST(marginx?.endTime),
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
                        FormatHelper.formatNumbers(marginx?.marginXTemplate?.entryFee, decimal: 0),
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
                        FormatHelper.formatNumbers(marginx?.marginXTemplate?.portfolioValue, decimal: 0),
                        style: Theme.of(context).textTheme.tsMedium12,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 4),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => Get.to(() => ViewCard(liveMarginX: marginx)),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(.25),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    'View Details',
                    style: AppStyles.tsWhiteMedium12.copyWith(
                      color: AppColors.info,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: controller.checkIfLivePurchased(marginx)
                    ? () {
                        controller.loadTradingData();
                        controller.liveMarginX(marginx);
                        Get.to(() => MarginXTradingView());
                      }
                    : () {
                        if (controller.calculateSeatsLeft(
                                marginx?.maxParticipants ?? 0, marginx?.participants?.length ?? 0) ==
                            0) {
                          SnackbarHelper.showSnackbar('Contest is Full');
                        } else {
                          BottomSheetHelper.openBottomSheet(
                            context: context,
                            child: PurchaseItemBottomSheet(
                              buyItemPrice: marginx?.marginXTemplate?.entryFee ?? 0,
                              onSubmit: () {
                                Get.back();
                                var data = {
                                  "entryFee": marginx?.marginXTemplate?.entryFee,
                                  "marginXId": marginx?.id,
                                  "marginXName": marginx?.marginXName,
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
                    controller.checkIfLivePurchased(marginx) &&
                            controller.calculateSeatsLeft(
                                    marginx?.maxParticipants ?? 0, marginx?.participants?.length ?? 0) >
                                0
                        ? 'Start Trading'
                        : controller.calculateSeatsLeft(
                                    marginx?.maxParticipants ?? 0, marginx?.participants?.length ?? 0) ==
                                0
                            ? 'MarginX Full'
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
                  controller.liveMarginX(marginx);
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
    );
  }
}
