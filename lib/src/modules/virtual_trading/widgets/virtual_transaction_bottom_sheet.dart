import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../modules.dart';

enum VirtualTransactionType { buy, sell, exit }

class VirtualTransactionBottomSheet extends GetView<VirtualTradingController> {
  final VirtualTransactionType type;
  final VirtualTradingInstrument data;

  const VirtualTransactionBottomSheet({
    super.key,
    required this.type,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
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
                    data.name ?? '-',
                    style: AppStyles.tsSecondaryMedium16,
                  ),
                  Text(
                    FormatHelper.formatNumbers(data.lastPrice),
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
              AbsorbPointer(
                absorbing: type == VirtualTransactionType.exit,
                child: DropdownButtonFormField<int>(
                  value: controller.selectedQuantity.value == 0 ? null : controller.selectedQuantity.value,
                  onChanged: (value) => controller.selectedQuantity(value),
                  menuMaxHeight: 250,
                  isDense: true,
                  items: AppConstants.instrumentsQuantity.map((int number) {
                    return DropdownMenuItem<int>(
                      value: number,
                      child: Text(number.toString()),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    // filled: true,
                    hintText: 'Quantity',
                    // fillColor: AppColors.grey.shade700,
                    hintStyle: AppStyles.tsGreyRegular14,
                    errorStyle: AppStyles.tsGreyRegular12.copyWith(
                      color: AppColors.danger.shade700,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 1,
                        color: AppColors.primary,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 1,
                        color: AppColors.danger,
                      ),
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
              CommonFilledButton(
                  backgroundColor: type == VirtualTransactionType.exit
                      ? AppColors.warning
                      : type == VirtualTransactionType.buy
                          ? AppColors.success
                          : AppColors.danger,
                  margin: EdgeInsets.symmetric(vertical: 24),
                  label: type == VirtualTransactionType.exit
                      ? 'Exit'
                      : type == VirtualTransactionType.buy
                          ? 'Buy'
                          : 'Sell',
                  onPressed: () =>
                      // Get.find<VirtualTradingController>().placeTenxTradingOrder(type, data),
                      ''),
            ],
          ),
        ),
      ],
    );
  }
}
