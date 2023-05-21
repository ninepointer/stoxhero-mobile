import 'package:flutter/material.dart';
import 'package:stoxhero/src/core/core.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 36,
            color: AppColors.netural.shade100,
          ),
          SizedBox(height: 8),
          Text(
            'No Data Found!',
            style: AppStyles.tsWhiteRegular16,
          ),
        ],
      ),
    );
  }
}
