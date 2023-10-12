import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../app/app.dart';

class TenxSearchInstrumentsCard extends GetView<TenxTradingController> {
  final TradingInstrument tradingInstrument;
  final bool isAdded;

  const TenxSearchInstrumentsCard({
    super.key,
    required this.tradingInstrument,
    required this.isAdded,
  });
  void openBottomSheet(BuildContext context, TransactionType type) {
    log('data: ${tradingInstrument.toJson()}');
    FocusScope.of(context).unfocus();
    num lastPrice = controller.getInstrumentLastPrice(
      tradingInstrument.instrumentToken!,
      tradingInstrument.exchangeToken!,
    );
    controller.generateLotsList(type: tradingInstrument.name);
    BottomSheetHelper.openBottomSheet(
      context: context,
      child: TenxTransactionBottomSheet(
        type: type,
        tradingInstrument: TradingInstrument(
          name: tradingInstrument.tradingsymbol,
          instrumentType: tradingInstrument.instrumentType,
          exchange: tradingInstrument.exchange,
          tradingsymbol: tradingInstrument.tradingsymbol,
          exchangeToken: tradingInstrument.exchangeToken,
          instrumentToken: tradingInstrument.instrumentToken,
          lastPrice: lastPrice,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      hasBorder: false,
      margin: EdgeInsets.all(8).copyWith(bottom: 0),
      padding: EdgeInsets.zero,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tradingInstrument.name ?? '-',
                    style: AppStyles.tsSecondaryMedium14,
                  ),
                  Text(
                    FormatHelper.formatDateByMonth(tradingInstrument.expiry),
                    style: AppStyles.tsSecondaryMedium14,
                  ),
                ],
              ),
              SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tradingInstrument.tradingsymbol ?? '-',
                    style: Theme.of(context).textTheme.tsMedium12,
                  ),
                  Text(
                    tradingInstrument.exchange ?? '-',
                    style: Theme.of(context).textTheme.tsMedium12,
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
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(.25),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    'BUY',
                    style: AppStyles.tsWhiteMedium12.copyWith(
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
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.danger.withOpacity(.25),
                  ),
                  child: Text(
                    'SELL',
                    style: AppStyles.tsWhiteMedium12.copyWith(
                      color: AppColors.danger,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: isAdded
                    ? () => Get.find<TenxTradingController>().removeInstrument(tradingInstrument.instrumentToken)
                    : () => Get.find<TenxTradingController>().addInstrument(tradingInstrument),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: isAdded ? AppColors.info.withOpacity(.25) : AppColors.secondary.withOpacity(.25),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    isAdded ? 'REMOVE' : 'ADD',
                    style: AppStyles.tsWhiteMedium12.copyWith(
                      color: isAdded ? AppColors.info : AppColors.secondary.shade600,
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
