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
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Container(
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
                        style: Theme.of(context).textTheme.tsSemiBold14,
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
                      style: Theme.of(context).textTheme.tsMedium12,
                    ),
                    SizedBox(width: 2),
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
      ),
    );
  }
}
