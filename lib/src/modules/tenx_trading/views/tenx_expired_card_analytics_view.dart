import 'package:flutter/material.dart';
import '../../../app/app.dart';

class TenXExpiredCardAnalticsView extends GetView<TenxTradingController> {
  const TenXExpiredCardAnalticsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final analyticsList =
        controller.tenxExpiredPlans.asMap().entries.map((entry) {
      TenxExpiredPlan plans = entry.value;
      return plans; // Assuming payout is the property you want to access
    }).toList();
    return Scaffold(
      appBar: AppBar(title: Text('Expired Tenx Analytics')),
      body: CommonCard(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(20),
        width: double.infinity,
        children: [
          Column(
            children: [
              for (var plans in analyticsList) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.grey.withOpacity(.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Gross P&L:',
                                style: AppStyles.tsSecondaryRegular14,
                              ),
                              // Text(subscription),
                              SizedBox(width: 10),
                              Text(
                                  plans.gpnl! > 0
                                      ? "+${FormatHelper.formatNumbers(plans.gpnl?.toStringAsFixed(0))}"
                                      : "${FormatHelper.formatNumbers(plans.gpnl?.toStringAsFixed(0))}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .tsMedium12
                                      .copyWith(
                                          color: plans.gpnl! > 0
                                              ? AppColors.success
                                              : AppColors.danger)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.grey.withOpacity(.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Net P&L:',
                                style: AppStyles.tsSecondaryRegular14,
                              ),
                              // Text(subscription),
                              SizedBox(width: 10),
                              Text(
                                  plans.npnl! > 0
                                      ? "+${FormatHelper.formatNumbers(plans.npnl?.toStringAsFixed(0))}"
                                      : "${FormatHelper.formatNumbers(plans.npnl?.toStringAsFixed(0))}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .tsMedium12
                                      .copyWith(
                                          color: plans.npnl! > 0
                                              ? AppColors.success
                                              : AppColors.danger)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.grey.withOpacity(.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Brokerage:',
                                style: AppStyles.tsSecondaryRegular14,
                              ),
                              // Text(subscription),
                              SizedBox(width: 10),
                              Text(
                                  '${FormatHelper.formatNumbers(plans.brokerage?.toStringAsFixed(0))}',
                                  style:
                                      Theme.of(context).textTheme.tsMedium12),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.grey.withOpacity(.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'TradingDays:',
                                style: AppStyles.tsSecondaryRegular14,
                              ),
                              // Text(subscription),
                              SizedBox(width: 10),
                              Text('${plans.tradingDays}',
                                  style:
                                      Theme.of(context).textTheme.tsMedium12),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.grey.withOpacity(.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Trades:',
                                style: AppStyles.tsSecondaryRegular14,
                              ),
                              SizedBox(width: 10),
                              Text('${plans.trades}',
                                  style:
                                      Theme.of(context).textTheme.tsMedium12),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ]
            ],
          ),
        ],
      ),
    );
  }
}
