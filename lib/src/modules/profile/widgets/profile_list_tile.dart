import 'package:flutter/material.dart';

import '../../../core/core.dart';

class ProfileListTile extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Function() onTap;

  const ProfileListTile({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.white,
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        minLeadingWidth: 0,
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.secondary.shade900.withOpacity(0.25),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: AppColors.secondary,
            size: 20,
          ),
        ),
        title: Text(
          label,
          style: AppStyles.tsGreyRegular16,
        ),
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: AppColors.netural.shade50,
        ),
        onTap: onTap,
      ),
    );
  }
}
