import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/app.dart';

class StoplossModifyPriceBottomSheet extends GetView<TenxTradingController> {
  final TradingInstrument stopLoss;
  const StoplossModifyPriceBottomSheet({
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Modify Order',
                        style: Theme.of(context).textTheme.tsMedium16,
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
                  height: 24,
                  color: AppColors.grey.shade50.withOpacity(0.5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Symbol',
                          style: AppStyles.tsGreyMedium12,
                        ),
                        Text(
                          stopLoss.name ?? '-',
                          style: AppStyles.tsSecondaryMedium14,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'LTP (Last Traded Price)',
                          style: AppStyles.tsGreyMedium12,
                        ),
                        Text(
                          FormatHelper.formatNumbers(
                            controller.getInstrumentLastPrice(
                              stopLoss.instrumentToken ?? 0,
                              stopLoss.exchangeToken ?? 0,
                            ),
                          ),
                          style: AppStyles.tsSecondaryMedium14,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Open Lots',
                          style: AppStyles.tsGreyMedium12,
                        ),
                        Text(
                          stopLoss.lotSize.toString(),
                          style: AppStyles.tsSecondaryMedium14,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Changes (%)',
                          style: AppStyles.tsGreyMedium12,
                        ),
                        Text(
                          controller.getInstrumentChanges(
                            stopLoss.instrumentToken ?? 0,
                            stopLoss.exchangeToken ?? 0,
                          ),
                          style: AppStyles.tsSecondaryMedium14,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                DropdownButtonFormField2<int>(
                  value: controller.selectedQuantity.value,
                  onChanged: (value) => controller.selectedQuantity(value),
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
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextField(
                        hintText: 'StopLoss Price',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                        ],
                        controller: controller.stopLossPriceTextController,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: CommonTextField(
                        hintText: 'StopProfit Price',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                        ],
                        controller: controller.stopProfitPriceTextController,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CommonRadioButtonTile(
                        value: 2,
                        groupValue: controller.selectedGroupValue.value,
                        label: 'SL/SP-M',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  AppStrings.noteModify,
                  style: Theme.of(context).textTheme.tsGreyMedium12,
                ),
                SizedBox(height: 12),
                CommonFilledButton(
                  label: 'MODIFY',
                  onPressed: () {},
                  backgroundColor: AppColors.secondary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
