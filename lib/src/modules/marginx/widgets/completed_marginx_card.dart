import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/data/data.dart';
import 'package:stoxhero/src/modules/marginx/marginx_index.dart';
import 'completed_marginx_share_sheet.dart';

import '../../../core/core.dart';

class CompletedMarginxCard extends GetView<MarginXController> {
  final CompletedMarginX? marginx;
  const CompletedMarginxCard({
    Key? key,
    this.marginx,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      padding: EdgeInsets.zero,
      children: [
        Container(
          // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          padding: EdgeInsets.only(left: 12, right: 12, top: 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  marginx?.marginxName ?? '-',
                  style: AppStyles.tsSecondaryMedium14,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: [
              Visibility(
                visible: marginx?.isNifty == true,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text(
                    'Nifty',
                    style: AppStyles.tsGreyMedium12,
                  ),
                ),
              ),
              SizedBox(width: 4),
              Visibility(
                visible: marginx?.isBankNifty == true,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text(
                    'Bank Nifty',
                    style: AppStyles.tsGreyMedium12,
                  ),
                ),
              ),
              SizedBox(width: 4),
              Visibility(
                visible: marginx?.isFinNifty == true,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text(
                    'Finnifty',
                    style: AppStyles.tsGreyMedium12,
                  ),
                ),
              ),
              SizedBox(width: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Text(
                  marginx?.marginxExpiry ?? '',
                  style: AppStyles.tsGreyMedium12,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.contestTrophy,
              width: 30,
              height: 20,
            ),
            SizedBox(height: 2),
            Text(
              '% of your Investment',
              style: Theme.of(context).textTheme.tsMedium12,
            ),
          ],
        ),
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Started:',
                    style: Theme.of(context).textTheme.tsGreyMedium12,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    FormatHelper.formatDateTimeWithoutYearToIST(
                        marginx?.startTime),
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Rubik'),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Ended:',
                    style: Theme.of(context).textTheme.tsGreyMedium12,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    FormatHelper.formatDateTimeWithoutYearToIST(
                        marginx?.endTime),
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Rubik'),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
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
                        'Virtual Margin',
                        style: AppStyles.tsGreyMedium12,
                      ),
                      SizedBox(height: 2),
                      Text(
                        FormatHelper.formatNumbers(marginx?.portfolioValue,
                            decimal: 0),
                        style: Theme.of(context).textTheme.tsMedium12,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Completed',
                        // style: Theme.of(context).textTheme.tsMedium12,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Entry Fee',
                        style: AppStyles.tsGreyMedium12,
                      ),
                      SizedBox(height: 2),
                      Text(
                        FormatHelper.formatNumbers(marginx?.entryFee,
                            decimal: 0),
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
                  Row(
                    children: [
                      Text(
                        'Net P&L: ',
                        style: AppStyles.tsGreyMedium12,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        (marginx?.npnl ?? 0) > 0
                            ? '+${FormatHelper.formatNumbers(marginx?.npnl ?? 0, decimal: 0)}'
                            : '${FormatHelper.formatNumbers(marginx?.npnl ?? 0, decimal: 0)}',
                        style: Theme.of(context).textTheme.tsMedium12.copyWith(
                              color: (marginx?.npnl ?? 0) >= 0
                                  ? AppColors.success
                                  : AppColors.danger,
                            ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'TDS:',
                        style: Theme.of(context).textTheme.tsGreyMedium12,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        FormatHelper.formatNumbers(marginx?.tds ?? 0,
                            decimal: 0),
                        style: Theme.of(context).textTheme.tsMedium12.copyWith(
                              color: (marginx?.earning ?? 0) >= 0
                                  ? AppColors.success
                                  : AppColors.danger,
                            ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Reward:',
                        style: Theme.of(context).textTheme.tsGreyMedium12,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        FormatHelper.formatNumbers(marginx?.earning ?? 0,
                            decimal: 0),
                        style: Theme.of(context).textTheme.tsMedium12.copyWith(
                              color: (marginx?.earning ?? 0) >= 0
                                  ? AppColors.success
                                  : AppColors.danger,
                            ),
                      )
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
                onTap: () {
                  Get.to(() => ViewCard(completedMarginX: marginx));
                },
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
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  final controller = Get.find<MarginXController>();
                  controller.getCompletedMarginXOrders(marginx?.marginxId);
                  controller.completedMarginX(marginx);
                  Get.to(() => CompletedMarginXOrdersListView());
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.25),
                  ),
                  child: Text(
                    'Order Book',
                    style: AppStyles.tsWhiteMedium12.copyWith(
                      color: AppColors.success,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  controller.completedMarginX(marginx);

                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Center(
                        child: ShareMarginXModalContent(
                          marginx: marginx,
                        ),
                      );
                    },
                  );
                  // }
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
