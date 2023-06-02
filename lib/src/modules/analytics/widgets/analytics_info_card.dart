// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:stoxhero/src/core/core.dart';

class AnalyticsInfoCard extends StatelessWidget {
  final String title;
  final num? grossValue, brokeValue, netValue;

  const AnalyticsInfoCard({
    super.key,
    required this.title,
    this.grossValue = 0.00,
    this.brokeValue = 0.00,
    this.netValue = 0.00,
  });

  Widget _buildListTile(
    String label,
    num? value,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppStyles.tsWhiteRegular14,
          ),
          SizedBox(height: 2),
          Text(
            FormatHelper.formatNumbers(value),
            style: AppStyles.tsWhiteMedium16.copyWith(
              color: value == null || value == 0
                  ? AppColors.info
                  : value < 0
                      ? AppColors.danger
                      : AppColors.success,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          color: AppColors.netural.shade800,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.secondary.shade900.withOpacity(0.5),
                ),
                child: Icon(
                  Icons.auto_graph_rounded,
                  size: 16,
                  color: AppColors.secondary,
                ),
              ),
              SizedBox(width: 8),
              Text(
                title,
                style: AppStyles.tsSecondaryMedium14,
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        _buildListTile(
          "Gross P & L",
          grossValue,
        ),
        SizedBox(height: 8),
        _buildListTile(
          "Net P & L",
          netValue,
        ),
        SizedBox(height: 8),
        _buildListTile(
          "Brokerage",
          brokeValue,
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
