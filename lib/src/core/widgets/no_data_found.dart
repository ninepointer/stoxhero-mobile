import 'package:flutter/material.dart';
import 'package:stoxhero/src/core/core.dart';

class NoDataFound extends StatelessWidget {
  final String? label;
  final String? imagePath;
  const NoDataFound({
    Key? key,
    this.label,
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          children: [
            imagePath == null
                ? Icon(
                    Icons.error_outline_rounded,
                    size: 36,
                    color: AppColors.grey.shade100,
                  )
                : Image.asset(
                    imagePath ?? '',
                    height: 48,
                    width: 48,
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
