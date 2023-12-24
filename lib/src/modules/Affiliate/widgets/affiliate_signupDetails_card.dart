import 'package:flutter/material.dart';
import 'package:stoxhero/src/core/core.dart';

class AffilateSignUpDetailsCard extends StatelessWidget {
  final int? rank;
  final String? name;
  final num? earnings;
  final String? date;
  const AffilateSignUpDetailsCard({
    super.key,
    this.rank,
    this.name,
    this.earnings,
    this.date,
  });
  @override
  Widget build(BuildContext context) {
    return CommonCard(
      margin: EdgeInsets.all(0).copyWith(bottom: 0, top: 8),
      children: [
        Row(
          children: [
            Text("$rank"),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${name ?? '-'}",
                    style: Theme.of(context).textTheme.tsRegular14,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Joining Date : ${FormatHelper.formatDateTimeOnlyToIST(date)}',
                    style: Theme.of(context).textTheme.tsGreyRegular10,
                  ),
                ],
              ),
            ),
            Text(
              FormatHelper.formatNumbers(earnings),
              style: Theme.of(context).textTheme.tsMedium16.copyWith(
                    color: AppColors.success,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
