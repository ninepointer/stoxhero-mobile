import 'package:flutter/material.dart';
import 'package:stoxhero/src/core/core.dart';

class NoDataFound extends StatelessWidget {
  final String? label;
  final Image? image;
  const NoDataFound({
    Key? key,
    this.label,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Column(
          children: [
            image ??
                Icon(
                  Icons.error_outline_rounded,
                  size: 36,
                  color: AppColors.grey.shade100,
                ),
            SizedBox(height: 8),
            Align(
              child: Text(
                label ?? 'No Data Found!',
                style: Theme.of(context).textTheme.tsRegular16,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
