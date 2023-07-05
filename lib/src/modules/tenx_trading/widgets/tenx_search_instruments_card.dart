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
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      children: [
        Divider(
          thickness: 1,
          height: 0,
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.name ?? '-',
                    style: AppStyles.tsSecondaryMedium14,
                  ),
                  Text(
                    FormatHelper.formatDateByMonth(data.expiry),
                    style: AppStyles.tsSecondaryMedium14,
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(data.tradingsymbol ?? '-'),
                  Text(data.exchange ?? '-'),
                ],
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1,
          height: 0,
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
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(4),
                    ),
                  ),
                  child: Text(
                    'BUY',
                    style: AppStyles.tsPrimaryMedium14.copyWith(
                      color: AppColors.success,
                    ),
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
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.danger.withOpacity(0.1),
                  ),
                  child: Text(
                    'SELL',
                    style: AppStyles.tsPrimaryMedium14.copyWith(
                      color: AppColors.danger,
                    ),
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
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isAdded ? AppColors.warning.withOpacity(0.1) : AppColors.info.withOpacity(0.1),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(4),
                    ),
                  ),
                  child: Text(
                    isAdded ? 'REMOVE' : 'ADD',
                    style: AppStyles.tsPrimaryMedium14.copyWith(
                      color: isAdded ? AppColors.warning : AppColors.info,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(
          thickness: 1,
          height: 0,
        ),
      ],
    );
  }
}
