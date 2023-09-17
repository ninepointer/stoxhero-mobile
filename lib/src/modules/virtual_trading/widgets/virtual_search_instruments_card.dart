import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../modules.dart';

class VirtualSearchInstrumentsCard extends GetView<VirtualTradingController> {
  final VirtualTradingInstrument data;
  final bool isAdded;

  const VirtualSearchInstrumentsCard({
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
                    builder: (context) => VirtualTransactionBottomSheet(
                      type: VirtualTransactionType.buy,
                      data: data,
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.2),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    'BUY',
                    style: AppStyles.tsWhiteMedium14.copyWith(
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
                    builder: (context) => VirtualTransactionBottomSheet(
                      type: VirtualTransactionType.sell,
                      data: data,
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.danger.withOpacity(0.2),
                  ),
                  child: Text(
                    'SELL',
                    style: AppStyles.tsWhiteMedium14.copyWith(
                      color: AppColors.danger,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: isAdded
                    ? () =>
                        Get.find<VirtualTradingController>().removeInstrument(data.instrumentToken)
                    : () => Get.find<VirtualTradingController>().addInstrument(data),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isAdded
                        ? AppColors.info.withOpacity(0.2)
                        : AppColors.secondary.withOpacity(0.2),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    isAdded ? 'REMOVE' : 'ADD',
                    style: AppStyles.tsWhiteMedium14.copyWith(
                      color: isAdded ? AppColors.info : AppColors.secondary,
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
