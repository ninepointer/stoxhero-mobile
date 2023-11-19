import 'package:flutter/material.dart';

import '../../../app/app.dart';

class ContestPerformanceCard extends StatelessWidget {
  final ContestProfile? contestProfile;
  final int index;
  const ContestPerformanceCard({
    super.key,
    this.contestProfile,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4),
      child: CommonCard(
        margin: EdgeInsets.symmetric(horizontal: 12),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(.25),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '#${index.toString()}',
              style: AppStyles.tsSecondarySemiBold14,
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonCardTile(
                label: 'TestZone Name',
                value: '${contestProfile?.contestName}',
              ),
              CommonCardTile(
                isRightAlign: true,
                label: 'Date',
                value: FormatHelper.formatDate(contestProfile?.contestStartTime),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Rank:',
                    style: AppStyles.tsGreyRegular12,
                  ),
                  Text(
                    '#${contestProfile?.rank}',
                    style: Theme.of(context).textTheme.tsMedium14,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Earnings:',
                    style: AppStyles.tsGreyRegular12,
                  ),
                  Text(
                    '${FormatHelper.formatNumbers(
                      contestProfile?.finalPayout,
                      decimal: 0,
                    )}',
                    style: Theme.of(context).textTheme.tsMedium14,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Type:',
                    style: AppStyles.tsGreyRegular12,
                  ),
                  Text(
                    '${contestProfile?.contestFor}',
                    style: Theme.of(context).textTheme.tsMedium14,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
