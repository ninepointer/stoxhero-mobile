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
    BuildContext context,
    String label,
    num? value,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.tsRegular14,
          ),
          SizedBox(height: 2),
          Text(
            FormatHelper.formatNumbers(value),
            style: Theme.of(context).textTheme.tsMedium16.copyWith(
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
          color: Theme.of(context).cardColor,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.secondary.withOpacity(0.25),
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
        Divider(thickness: 1, height: 0),
        SizedBox(height: 8),
        _buildListTile(
          context,
          "Gross P & L",
          grossValue,
        ),
        SizedBox(height: 8),
        _buildListTile(
          context,
          "Net P & L",
          netValue,
        ),
        SizedBox(height: 8),
        _buildListTile(
          context,
          "Brokerage",
          brokeValue,
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
