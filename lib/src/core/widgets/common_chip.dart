import 'package:flutter/material.dart';
import '../../app/app.dart';

class CommonChip extends StatelessWidget {
  final String? label;
  final VoidCallback? onTap;
  final bool isSelected;
  const CommonChip({
    Key? key,
    this.onTap,
    this.label,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Chip(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: AppColors.primary,
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
          style: isSelected ? AppStyles.tsWhiteRegular14 : AppStyles.tsPrimaryRegular14,
        ),
        backgroundColor: isSelected ? AppColors.primary : Colors.transparent,
      ),
    );
  }
}
