import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

import '../../../core/core.dart';

class IndexCard extends StatelessWidget {
  final String? label;
  final dynamic stockPrice;
  final String? stockLTP;
  final String? stockChange;
  final Color? stockColor;
  final Color? stockLTPColor;
  const IndexCard({
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
    return Container(
      decoration: BoxDecoration(
        color: Get.isDarkMode ? Color(0xFF1B2937) : Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      width: 117,
      child: CommonCard(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                          style: AppStyles.tsSecondaryMedium14,
                        ),
                        Text(
                          stockPrice ?? '-',
                          style:
                              Theme.of(context).textTheme.tsMedium12.copyWith(
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
                SizedBox(height: 2),
                FittedBox(
                  child: Row(
                    children: [
                      Text(
                        stockLTP ?? '',
                        style:
                            Theme.of(context).textTheme.tsGreyMedium10.copyWith(
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
