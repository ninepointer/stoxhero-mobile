import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../../../app/app.dart';

class CollegeContestTransactionBottomSheet extends GetView<CollegeContestController> {
  final TradingInstrument tradingInstrument;
  final TransactionType type;
  final dynamic marginRequired;
  const CollegeContestTransactionBottomSheet({
    super.key,
    required this.type,
    required this.tradingInstrument,
    required this.marginRequired,
  });

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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Regular',
                        style: Theme.of(context).textTheme.tsMedium18,
                      ),
                      Icon(
                        Icons.cancel,
                        color: AppColors.secondary,
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  height: 36,
                  color: AppColors.grey.shade50.withOpacity(0.5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tradingInstrument.name ?? '',
                      style: AppStyles.tsSecondaryMedium16,
                    ),
                    Text(
                      type == TransactionType.buy
                          ? FormatHelper.formatNumbers(tradingInstrument.lastPrice)
                          : type == TransactionType.sell
                              ? FormatHelper.formatNumbers(tradingInstrument.lastPrice)
                              : tradingInstrument.lotSize.toString(),
                      style: AppStyles.tsSecondaryMedium16,
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: CommonRadioButtonTile(
                        value: 2,
                        groupValue: 1,
                        label: 'Interaday (MIS)',
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: CommonRadioButtonTile(
                        value: 1,
                        groupValue: 1,
                        label: 'Overnight (NRML)',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                DropdownButtonFormField2<int>(
                  value: controller.selectedQuantity.value,
                  onChanged: (value) {
                    controller.selectedQuantity(value);
                    controller.getMarginRequired(type, tradingInstrument);
                  },
                  isDense: true,
                  items: controller.lotsValueList.map((int number) {
                    return DropdownMenuItem<int>(
                      value: number,
                      child: Text(number >= 0 ? number.toString() : number.toString()),
                    );
                  }).toList(),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  menuItemStyleData: MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(16).copyWith(left: 0),
                    filled: true,
                    fillColor: AppColors.grey.withOpacity(.1),
                    hintText: 'Quantity',
                    hintStyle: AppStyles.tsGreyRegular14,
                    errorStyle: AppStyles.tsGreyRegular12.copyWith(
                      color: AppColors.danger.shade700,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 2,
                        color: AppColors.primary,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 2,
                        color: AppColors.danger,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextField(
                        isDisabled: true,
                        hintText: 'Price',
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: CommonTextField(
                        isDisabled: true,
                        hintText: 'Trigger',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CommonRadioButtonTile(
                        value: 2,
                        groupValue: 2,
                        label: 'MARKET',
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: CommonRadioButtonTile(
                        value: 1,
                        groupValue: 2,
                        label: 'LIMIT',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: CommonRadioButtonTile(
                        value: 3,
                        groupValue: 2,
                        label: 'SL',
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: CommonRadioButtonTile(
                        value: 4,
                        groupValue: 2,
                        label: 'SL-M',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: CommonRadioButtonTile(
                        value: 3,
                        groupValue: 3,
                        label: 'Day',
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: CommonRadioButtonTile(
                        value: 4,
                        groupValue: 3,
                        label: 'Immediate',
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: CommonRadioButtonTile(
                        value: 1,
                        groupValue: 3,
                        label: 'Minutes',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                CommonCard(
                  margin: EdgeInsets.only(),
                  padding: EdgeInsets.zero.copyWith(left: 12),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Margin Required',
                          style: Theme.of(context).textTheme.tsMedium14,
                        ),
                        Visibility(
                          visible: controller.isMarginStateLoadingStatus,
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: SizedBox(
                              child: CommonLoader(),
                              height: 24,
                              width: 24,
                            ),
                          ),
                          replacement: Row(
                            children: [
                              Text(
                                FormatHelper.formatNumbers(controller.marginRequired.value.margin),
                                style: Theme.of(context).textTheme.tsMedium14,
                              ),
                              IconButton(
                                onPressed: () => controller.getMarginRequired(type, tradingInstrument),
                                icon: Icon(Icons.refresh, size: 18),
                                splashRadius: 18,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                CommonFilledButton(
                  isLoading: controller.isTradingOrderSheetLoading.value,
                  backgroundColor: type == TransactionType.exit
                      ? AppColors.warning
                      : tradingInstrument.lotSize.toString().contains('-')
                          ? type == TransactionType.buy
                              ? AppColors.danger
                              : AppColors.success
                          : type == TransactionType.buy
                              ? AppColors.success
                              : AppColors.danger,
                  margin: EdgeInsets.symmetric(vertical: 24),
                  label: type == TransactionType.exit
                      ? 'Exit'
                      : tradingInstrument.lotSize.toString().contains('-')
                          ? type == TransactionType.buy
                              ? 'SELL'
                              : 'BUY'
                          : type == TransactionType.buy
                              ? 'BUY'
                              : 'SELL',
                  onPressed: () {
                    Get.find<CollegeContestController>().placeContestOrder(
                      type,
                      tradingInstrument,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
