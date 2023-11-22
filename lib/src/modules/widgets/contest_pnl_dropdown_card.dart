import 'package:flutter/material.dart';

import '../../app/app.dart';

class ContestPnlDropdownCard extends StatefulWidget {
  const ContestPnlDropdownCard({Key? key}) : super(key: key);

  @override
  _ContestPnlDropdownCardState createState() => _ContestPnlDropdownCardState();
}

class _ContestPnlDropdownCardState extends State<ContestPnlDropdownCard> {
  late CollegeContestController controller;
  @override
  void initState() {
    super.initState();
    controller = Get.find<CollegeContestController>();
  }

  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    print('daywiseLength - ${controller.dayWiseContestPnlList.length}');
    return CommonCard(
      hasBorder: false,
      margin: EdgeInsets.symmetric(horizontal: 8),
      onTap: () => setState(() => isExpanded = !isExpanded),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'TestZone Net P&L:',
                  style: AppStyles.tsSecondaryMedium14,
                ),
                SizedBox(width: 4),
                Text(
                  FormatHelper.formatNumbers(controller.calculateTotalNetPNL()),
                  style: AppStyles.tsSecondaryMedium14.copyWith(
                    color: controller.getValueColor(
                      controller.calculateTotalNetPNL(),
                    ),
                  ),
                ),
              ],
            ),
            Icon(
              isExpanded
                  ? Icons.expand_less_rounded
                  : Icons.expand_more_rounded,
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
                DataColumn(
                  label: Text('Date'),
                ),
                DataColumn(
                  label: Text('Gross P&L'),
                ),
                DataColumn(
                  label: Text('Brokerage'),
                ),
                DataColumn(
                  label: Text('Net P&L'),
                ),
                DataColumn(
                  label: Text('# Trades'),
                ),
              ],
              rows: [
                DataRow(
                  cells: [
                    DataCell(
                      Text(
                        FormatHelper.formatDateMonth(
                          DateTime.now().toString(),
                        ),
                        style: AppStyles.tsGreyMedium12,
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(
                          FormatHelper.formatNumbers(
                            controller.calculateContestGrossPNL(),
                          ),
                          style: AppStyles.tsGreyMedium12.copyWith(
                            color: controller.getValueColor(
                              controller.calculateContestGrossPNL(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(
                          FormatHelper.formatNumbers(
                            controller.calculateContestBrokerage(),
                          ),
                          style: AppStyles.tsSecondaryMedium12,
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(
                          FormatHelper.formatNumbers(
                            controller.calculateContestNetPNL(),
                          ),
                          style: AppStyles.tsSecondaryMedium12.copyWith(
                            color: controller.getValueColor(
                              controller.calculateContestNetPNL(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(
                          '${controller.calculateContestTrades()}',
                          style: AppStyles.tsGreyMedium12,
                        ),
                      ),
                    ),
                  ],
                ),
                for (var i = 0;
                    i < controller.dayWiseContestPnlList.length;
                    i++)
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          FormatHelper.formatDateMonth(
                              controller.dayWiseContestPnlList[i].date),
                          style: AppStyles.tsGreyMedium12,
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Text(
                            FormatHelper.formatNumbers(
                              controller.dayWiseContestPnlList[i].gpnl,
                            ),
                            style: AppStyles.tsSecondaryMedium12.copyWith(
                              color: controller.getValueColor(
                                controller.dayWiseContestPnlList[i].gpnl,
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Text(
                            FormatHelper.formatNumbers(
                              controller.dayWiseContestPnlList[i].brokerage,
                            ),
                            style: AppStyles.tsSecondaryMedium12,
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Text(
                            FormatHelper.formatNumbers(
                              controller.dayWiseContestPnlList[i].npnl,
                            ),
                            style: AppStyles.tsSecondaryMedium12.copyWith(
                              color: controller.getValueColor(
                                controller.dayWiseContestPnlList[i].npnl,
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Text(
                            '${controller.dayWiseContestPnlList[i].trades}',
                            style: AppStyles.tsGreyMedium12,
                          ),
                        ),
                      ),
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
                    DataCell(
                      Center(
                        child: Text(
                          FormatHelper.formatNumbers(
                            controller.calculateTotalDayPNLList()[0],
                          ),
                          style: AppStyles.tsSecondaryMedium12.copyWith(
                            color: controller.getValueColor(
                              controller.calculateTotalDayPNLList()[0],
                            ),
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(
                          FormatHelper.formatNumbers(
                            controller.calculateTotalDayPNLList()[1],
                          ),
                          style: AppStyles.tsSecondaryMedium12,
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(
                          FormatHelper.formatNumbers(
                            controller.calculateTotalDayPNLList()[2],
                          ),
                          style: AppStyles.tsSecondaryMedium12.copyWith(
                            color: controller.getValueColor(
                              controller.calculateTotalDayPNLList()[2],
                            ),
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(
                          '${controller.calculateTotalDayPNLList()[3]}',
                          style: AppStyles.tsGreyMedium12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}
