import 'package:flutter/material.dart';

import '../../app/app.dart';

class ContestPnlDropdownCard extends StatefulWidget {
  const ContestPnlDropdownCard({Key? key}) : super(key: key);

  @override
  _ContestPnlDropdownCardState createState() => _ContestPnlDropdownCardState();
}

class _ContestPnlDropdownCardState extends State<ContestPnlDropdownCard> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return CommonCard(
      margin: EdgeInsets.symmetric(horizontal: 8),
      onTap: () => setState(() => isExpanded = !isExpanded),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Contest Net P&L',
              style: AppStyles.tsSecondaryRegular14,
            ),
            Icon(
              isExpanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
              color: AppColors.grey,
            ),
          ],
        ),
        if (isExpanded)
          Container(
            width: MediaQuery.of(context).size.width,
            child: DataTable(
              columnSpacing: 12,
              horizontalMargin: 4,
              dataRowMinHeight: 24,
              dataRowMaxHeight: 36,
              headingRowHeight: 40,
              headingTextStyle: Theme.of(context).textTheme.tsGreyMedium12,
              columns: [
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Gross P&L')),
                DataColumn(label: Text('Brokerage')),
                DataColumn(label: Text('Net P&L')),
                DataColumn(label: Text('# Trades')),
              ],
              rows: [
                for (var i = 0; i < 5; i++)
                  DataRow(
                    cells: [
                      DataCell(Text('Value')),
                      DataCell(Text('Value')),
                      DataCell(Text('Value')),
                      DataCell(Text('Value')),
                      DataCell(Text('Value')),
                    ],
                  ),
                DataRow(
                  cells: [
                    DataCell(
                      Text(
                        'Total',
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                    ),
                    DataCell(Text('Total')),
                    DataCell(Text('Total')),
                    DataCell(Text('Total')),
                    DataCell(Text('Total')),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}
