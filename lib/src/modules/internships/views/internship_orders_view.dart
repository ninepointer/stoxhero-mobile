import 'package:flutter/material.dart';
import '../../../app/app.dart';

class InternshipOrdersView extends StatefulWidget {
  const InternshipOrdersView({Key? key}) : super(key: key);

  @override
  State<InternshipOrdersView> createState() => _InternshipOrdersViewState();
}

class _InternshipOrdersViewState extends State<InternshipOrdersView> {
  late InternshipController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<InternshipController>();
  }

  Widget _buildOrdersListView(List<InternshipOrdersList> ordersList) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: ordersList.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var order = ordersList[index];
        return CommonCard(
          margin: EdgeInsets.all(16).copyWith(bottom: 0, top: 8),
          children: [
            OrderCardTile(
              label: 'Symbol',
              value: order.symbol,
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OrderCardTile(
                  label: 'Quantity',
                  value: order.quantity.toString(),
                ),
                OrderCardTile(
                  isRightAlign: true,
                  label: 'Price',
                  value: FormatHelper.formatNumbers(order.averagePrice),
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OrderCardTile(
                  label: 'Amount',
                  value: FormatHelper.formatNumbers(
                    order.amount,
                    isNegative: true,
                  ),
                ),
                OrderCardTile(
                  isRightAlign: true,
                  label: 'Type',
                  value: order.buyOrSell,
                  valueColor: order.buyOrSell == AppConstants.buy ? AppColors.success : AppColors.danger,
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OrderCardTile(
                  label: 'Order ID',
                  value: order.orderId,
                ),
                OrderCardTile(
                  isRightAlign: true,
                  label: 'Status',
                  value: order.status,
                  valueColor: order.status == AppConstants.complete ? AppColors.success : AppColors.danger,
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OrderCardTile(
                  label: 'Timestamp',
                  value: FormatHelper.formatDateTime(order.tradeTime),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Internship Order'),
      ),
      body: Obx(
        () => CommonTabBar(
          index: controller.selectedTabBarIndex.value,
          onTap: controller.changeTabBarIndex,
          tabsTitle: [
            "Today's Orders",
            "All Orders",
          ],
          tabs: [
            RefreshIndicator(
              onRefresh: controller.getInternshipTodayOrdersList,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: 100),
                child: Visibility(
                  visible: controller.isTodaysOrdersLoadingStatus,
                  child: ListViewShimmer(
                    shimmerCard: LargeCardShimmer(),
                  ),
                  replacement: Visibility(
                    visible: controller.internshipTodayOrders.isEmpty,
                    child: NoDataFound(
                      imagePath: AppImages.contestTrophy,
                      label: AppStrings.noDataFoundForPremiumLiveMarginX,
                    ),
                    replacement: _buildOrdersListView(controller.internshipTodayOrders),
                  ),
                ),
              ),
            ),
            RefreshIndicator(
              onRefresh: controller.getInternshipAllOrdersList,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: 100),
                child: Visibility(
                  visible: controller.isAllOrdersLoadingStatus,
                  child: ListViewShimmer(
                    shimmerCard: LargeCardShimmer(),
                  ),
                  replacement: Visibility(
                    visible: controller.internshipAllOrders.isEmpty,
                    child: NoDataFound(
                      imagePath: AppImages.contestTrophy,
                      label: AppStrings.noDataFoundForPremiumLiveMarginX,
                    ),
                    replacement: _buildOrdersListView(controller.internshipAllOrders),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
