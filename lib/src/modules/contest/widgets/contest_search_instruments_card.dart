import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../app/app.dart';

class ContestSearchInstrumentsCard extends GetView<ContestController> {
  final TradingInstrument tradingInstrument;
  final bool isAdded;

  const ContestSearchInstrumentsCard({
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
      child: ContestTransactionBottomSheet(
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
                    style: AppStyles.tsSecondaryMedium16,
                  ),
                  Text(
                    FormatHelper.formatDateByMonth(tradingInstrument.expiry),
                    style: AppStyles.tsSecondaryMedium16,
                  ),
                ],
              ),
              SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tradingInstrument.tradingsymbol ?? '-',
                    style: Theme.of(context).textTheme.tsMedium14,
                  ),
                  Text(
                    tradingInstrument.exchange ?? '-',
                    style: Theme.of(context).textTheme.tsMedium14,
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
                  padding: EdgeInsets.all(8),
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
                  padding: EdgeInsets.all(8),
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
                    ? () => Get.find<ContestController>().removeInstrument(tradingInstrument.instrumentToken)
                    : () => Get.find<ContestController>().addInstrument(tradingInstrument),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8),
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
