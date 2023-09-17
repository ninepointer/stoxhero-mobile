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
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        minLeadingWidth: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.secondary.withOpacity(0.25),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon ?? Icons.widgets,
            color: AppColors.secondary,
            size: 20,
          ),
        ),
        title: Text(
          label,
          style: Theme.of(context).textTheme.tsRegular16,
        ),
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: AppColors.grey,
        ),
        onTap: onTap,
      ),
    );
  }
}
