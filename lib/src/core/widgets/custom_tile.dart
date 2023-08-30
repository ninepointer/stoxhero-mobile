import 'package:flutter/material.dart';

import '../core.dart';

class CustomTile extends StatelessWidget {
  final String label;

  const CustomTile({super.key, this.label = 'Label'});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Theme.of(context).cardColor,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppStyles.tsSecondaryRegular16,
          ),
        ],
      ),
    );
  }
}
