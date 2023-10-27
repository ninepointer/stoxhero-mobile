import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/app.dart';

class StoplossEditPriceBottomSheet extends GetView<TenxTradingController> {
  final StopLossPendingOrdersList stopLoss;
  const StoplossEditPriceBottomSheet({
    Key? key,
    required this.stopLoss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: Get.back,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Edit Price',
                            style: Theme.of(context).textTheme.tsMedium16,
                          ),
                          Icon(
                            Icons.cancel,
                            color: AppColors.secondary,
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            stopLoss.type ?? '',
                            style: Theme.of(context).textTheme.tsMedium16.copyWith(
                                  color: stopLoss.type == 'StopLoss' ? AppColors.danger : AppColors.success,
                                ),
                          ),
                          Text(
                            stopLoss.buyOrSell ?? '',
                            style: Theme.of(context).textTheme.tsMedium16.copyWith(
                                  color: stopLoss.buyOrSell == 'SELL' ? AppColors.danger : AppColors.success,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  height: 24,
                  color: AppColors.grey.shade50.withOpacity(0.5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // '',
                      stopLoss.symbol ?? '-',
                      style: AppStyles.tsSecondaryMedium16,
                    ),
                    Text(
                      FormatHelper.formatNumbers(
                        controller.getInstrumentLastPrice(
                          stopLoss.instrumentToken ?? 0,
                          stopLoss.exchangeInstrumentToken ?? 0,
                        ),
                      ),
                      // '',
                      style: AppStyles.tsSecondaryMedium16,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextField(
                        hintText: 'Quantity',
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: CommonTextField(
                        hintText: 'StopLoss Price',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                        ],
                        controller: controller.stopLossPriceTextController,
                      ),
                    ),
                  ],
                ),
                CommonFilledButton(
                  isLoading: controller.isTradingOrderSheetLoading.value,
                  label: 'Edit',
                  backgroundColor: AppColors.secondary,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
