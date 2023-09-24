import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../modules.dart';

class VirtualSearchInstrumentsCard extends GetView<VirtualTradingController> {
  final TradingInstrument data;
  final bool isAdded;
  const VirtualSearchInstrumentsCard({
    super.key,
    required this.data,
    required this.isAdded,
  });

  void openBottomSheet(BuildContext context, TransactionType type) {
    log('data: ${data.toJson()}');
    FocusScope.of(context).unfocus();
    num lastPrice = controller.getInstrumentLastPrice(
      data.instrumentToken!,
      data.exchangeToken!,
    );
    showBottomSheet(
      context: context,
      builder: (context) => VirtualTransactionBottomSheet(
        type: type,
        data: VirtualTradingInstrument(
          name: data.tradingsymbol,
          instrumentType: data.instrumentType,
          exchange: data.exchange,
          tradingsymbol: data.tradingsymbol,
          exchangeToken: data.exchangeToken,
          instrumentToken: data.instrumentToken,
          lastPrice: lastPrice,
        ),
      ),
    );
  }

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
                onTap: () => openBottomSheet(context, TransactionType.buy),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(.25),
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
                onTap: () => openBottomSheet(context, TransactionType.sell),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.danger.withOpacity(.25),
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
                    ? () => Get.find<VirtualTradingController>().removeInstrument(data.instrumentToken)
                    : () => Get.find<VirtualTradingController>().addInstrument(data),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isAdded ? AppColors.info.withOpacity(.25) : AppColors.secondary.withOpacity(.25),
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
