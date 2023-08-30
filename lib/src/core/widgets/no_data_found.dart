import 'package:flutter/material.dart';
import 'package:stoxhero/src/core/core.dart';

class NoDataFound extends StatelessWidget {
  final String? label;
  const NoDataFound({
    Key? key,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 36,
            color: AppColors.grey.shade100,
          ),
          SizedBox(height: 8),
          Text(
            label ?? 'No Data Found!',
            style: Theme.of(context).textTheme.tsRegular16,
          ),
        ],
      ),
    );
  }
}
