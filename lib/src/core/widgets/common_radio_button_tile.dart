import 'package:flutter/material.dart';

import '../core.dart';

class CommonRadioButtonTile extends StatelessWidget {
  final String label;
  final int value;
  final int groupValue;

  const CommonRadioButtonTile({
    super.key,
    required this.label,
    required this.value,
    required this.groupValue,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.grey.shade50.withOpacity(0.5),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Radio(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: value,
              groupValue: groupValue,
              activeColor: AppColors.secondary,
              onChanged: (value) {},
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.tsRegular14,
            ),
          ],
        ),
      ),
    );
  }
}
