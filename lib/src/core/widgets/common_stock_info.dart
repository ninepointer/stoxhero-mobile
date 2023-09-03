import 'package:flutter/material.dart';

import '../core.dart';

class CommonStockInfo extends StatelessWidget {
  final String label;
  final String stockPrice;
  final String stockLTP;
  final String stockChange;
  const CommonStockInfo({
    Key? key,
    required this.label,
    required this.stockPrice,
    required this.stockLTP,
    required this.stockChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CommonCard(
        margin: EdgeInsets.all(8).copyWith(
          bottom: 0,
          right: 0,
        ),
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: AppStyles.tsSecondaryMedium16,
                        ),
                        SizedBox(height: 4),
                        Text(
                          stockPrice,
                          style: Theme.of(context).textTheme.tsMedium14,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 6),
                FittedBox(
                  child: Row(
                    children: [
                      Text(
                        stockLTP,
                        style: Theme.of(context).textTheme.tsGreyRegular12,
                      ),
                      SizedBox(width: 4),
                      Text(
                        stockChange,
                        style: AppStyles.tsWhiteMedium10.copyWith(
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
