import 'package:flutter/material.dart';
import '../../app/app.dart';

class CommonChip extends StatelessWidget {
  final String? label;
  final VoidCallback? onTap;
  final bool isSelected;
  final EdgeInsets? margin;
  const CommonChip({
    Key? key,
    this.onTap,
    this.label,
    this.isSelected = false,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: GestureDetector(
        onTap: onTap,
        child: Chip(
          visualDensity: VisualDensity.compact,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: AppColors.lightGreen,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          avatar: isSelected
              ? Icon(
                  Icons.check,
                  color: AppColors.white,
                )
              : null,
          label: Text(
            label ?? 'Label',
            style: isSelected
                ? AppStyles.tsWhiteMedium12
                : AppStyles.tsPrimaryMedium12
                    .copyWith(color: AppColors.lightGreen),
          ),
          backgroundColor:
              isSelected ? AppColors.lightGreen : Theme.of(context).cardColor,
        ),
      ),
    );
  }
}
