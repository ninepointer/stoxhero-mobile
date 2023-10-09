import 'package:flutter/material.dart';

import '../core.dart';

class CommonStockInfo extends StatelessWidget {
  final String? label;
  final dynamic stockPrice;
  final String? stockLTP;
  final String? stockChange;
  final Color? stockColor;
  final Color? stockLTPColor;
  const CommonStockInfo({
    Key? key,
    required this.label,
    required this.stockPrice,
    this.stockLTP,
    this.stockChange,
    this.stockColor,
    this.stockLTPColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CommonCard(
        margin: EdgeInsets.zero,
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
                          label ?? '-',
                          style: AppStyles.tsSecondaryMedium16,
                        ),
                        SizedBox(height: 4),
                        Text(
                          stockPrice ?? '-',
                          style: Theme.of(context).textTheme.tsMedium14.copyWith(
                                color: stockColor ??
                                    (stockPrice!.startsWith('-')
                                        ? AppColors.danger
                                        : AppColors.success),
                              ),
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
                        stockLTP ?? '',
                        style: Theme.of(context).textTheme.tsGreyMedium12.copyWith(
                              color: stockLTPColor,
                            ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        stockChange ?? '',
                        style: AppStyles.tsWhiteMedium10.copyWith(
                          color: stockLTPColor,
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
