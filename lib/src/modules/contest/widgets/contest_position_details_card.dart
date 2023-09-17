import 'package:flutter/material.dart';
import 'package:stoxhero/src/core/core.dart';

class ContestPositionDetailsCard extends StatelessWidget {
  final String? label;
  final num? value;
  final bool isNum;

  const ContestPositionDetailsCard({
    super.key,
    this.label,
    this.value,
    this.isNum = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CommonCard(
        margin: EdgeInsets.zero,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label ?? '-',
                style: Theme.of(context).textTheme.tsRegular12,
              ),
              Text(
                FormatHelper.formatNumbers(
                  value,
                  showSymbol: !isNum,
                  decimal: isNum ? 0 : 2,
                ),
                style: Theme.of(context).textTheme.tsMedium14.copyWith(
                      color: value! < 0 ? AppColors.danger : AppColors.success,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
