import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../modules.dart';

class TenxSearchInstrumentsCard extends GetView<TenxTradingController> {
  final TenxTradingInstrument data;
  final bool isAdded;

  const TenxSearchInstrumentsCard({
    super.key,
    required this.data,
    required this.isAdded,
  });

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      hasBorder: false,
      margin: EdgeInsets.symmetric(horizontal: 12),
      padding: EdgeInsets.zero,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.name ?? '-',
                    style: AppStyles.tsSecondaryMedium16,
                  ),
                  Text(
                    FormatHelper.formatDateByMonth(data.expiry),
                    style: AppStyles.tsSecondaryMedium16,
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.tradingsymbol ?? '-',
                    style: Theme.of(context).textTheme.tsRegular14,
                  ),
                  Text(
                    data.exchange ?? '-',
                    style: Theme.of(context).textTheme.tsRegular14,
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  log('instrument : ${data.toJson()}');
                  FocusScope.of(context).unfocus();
                  showBottomSheet(
                    context: context,
                    builder: (context) => TenxTransactionBottomSheet(
                      type: TransactionType.buy,
                      data: data,
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.success.shade400,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    'BUY',
                    style: AppStyles.tsWhiteMedium14,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  log('instrument : ${data.toJson()}');
                  FocusScope.of(context).unfocus();
                  showBottomSheet(
                    context: context,
                    builder: (context) => TenxTransactionBottomSheet(
                      type: TransactionType.sell,
                      data: data,
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.danger.shade400,
                  ),
                  child: Text(
                    'SELL',
                    style: AppStyles.tsWhiteMedium14,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: isAdded
                    ? () => Get.find<TenxTradingController>().removeInstrument(data.instrumentToken)
                    : () => Get.find<TenxTradingController>().addInstrument(data),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isAdded ? AppColors.info.shade400 : AppColors.secondary.shade400,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    isAdded ? 'REMOVE' : 'ADD',
                    style: AppStyles.tsWhiteMedium14,
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
