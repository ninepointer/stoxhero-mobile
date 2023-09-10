import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'package:stoxhero/src/core/core.dart';
import 'package:stoxhero/src/modules/modules.dart';

import '../../../data/models/response/upcoming_marginx_list_response.dart';

class UpcomingMarginxCard extends StatelessWidget {
  final String? marginXName;
  final String? startTime;
  final String? endTime;
  final int? maxParticipants;
  final bool? isNifty;
  final bool? isBankNifty;
  final bool? isFinNifty;
  final MarginXTemplate? marginXTemplate;
  final int? portfolio;
  final int? entryFee;
  final String? marginXExpiry;
  final String? marginXStatus;

  const UpcomingMarginxCard({
    Key? key,
    this.marginXName,
    this.startTime,
    this.endTime,
    this.maxParticipants,
    this.isNifty,
    this.isBankNifty,
    this.isFinNifty,
    this.marginXTemplate,
    this.portfolio,
    this.entryFee,
    this.marginXExpiry,
    this.marginXStatus,
  }) : super(key: key);

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
                    marginXName ?? '-',
                    style: AppStyles.tsSecondaryMedium16,
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
                visible: isNifty == true,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                visible: isBankNifty == true,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                visible: isFinNifty == true,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.danger,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  marginXExpiry ?? '',
                  style: AppStyles.tsWhiteMedium12,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
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
                          style: AppStyles.tsGreyRegular14,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '$maxParticipants',
                          style: Theme.of(context).textTheme.tsMedium14,
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
                        style: AppStyles.tsGreyRegular14,
                      ),
                      Text(
                        '% of your Investment',
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Remaining',
                          style: AppStyles.tsGreyRegular14,
                        ),
                        SizedBox(height: 4),
                        Text(
                          "00:00:00",
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
                        style: AppStyles.tsGreyRegular14,
                      ),
                      SizedBox(height: 4),
                      Text(
                        FormatHelper.formatDateTimeToIST(startTime),
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'End Date & Time',
                        style: AppStyles.tsGreyRegular14,
                      ),
                      SizedBox(height: 4),
                      Text(
                        FormatHelper.formatDateTimeToIST(endTime),
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
                        style: AppStyles.tsGreyRegular14,
                      ),
                      SizedBox(height: 4),
                      Text(
                        FormatHelper.formatNumbers(entryFee, decimal: 0),
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Portfolio',
                        style: AppStyles.tsGreyRegular14,
                      ),
                      SizedBox(height: 4),
                      Text(
                        FormatHelper.formatNumbers(portfolio, decimal: 0),
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
                onTap: () {
                  Get.to(ViewCard());
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(.25),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    'View',
                    style: AppStyles.tsWhiteMedium14.copyWith(
                      color: AppColors.info,
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
    );
  }
}
