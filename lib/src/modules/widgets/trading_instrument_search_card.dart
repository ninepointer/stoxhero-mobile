import 'package:flutter/material.dart';

import '../../app/app.dart';

class TradingInstrumentSearchCard extends StatelessWidget {
  final TradingInstrument tradingInstrument;
  final bool isAdded;
  final VoidCallback buyOnTap;
  final VoidCallback sellOnTap;
  final VoidCallback addOnTap;
  final VoidCallback removeOnTap;

  const TradingInstrumentSearchCard({
    super.key,
    required this.tradingInstrument,
    required this.isAdded,
    required this.buyOnTap,
    required this.sellOnTap,
    required this.removeOnTap,
    required this.addOnTap,
  });

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
                onTap: buyOnTap,
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
                onTap: sellOnTap,
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
                onTap: isAdded ? removeOnTap : addOnTap,
                // onTap: isAdded
                //     ? () => Get.find<VirtualTradingController>().removeInstrument(tradingInstrument.instrumentToken)
                //     : () => Get.find<VirtualTradingController>().addInstrument(tradingInstrument),
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
