import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/app/app.dart';
import 'package:stoxhero/src/core/core.dart';
import 'package:stoxhero/src/modules/stocks/controllers/stocks_controller.dart';
import 'package:stoxhero/src/modules/stocks/views/stocks_dashboard_view.dart';

class FutureAndOptionDashBoard extends StatelessWidget {
  const FutureAndOptionDashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(
        MediaQuery.of(context).size.width * 0.0306,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Learn with StoxHero",
                style: Get.isDarkMode
                    ? AppStyles.tsprimarywhiteMedium20
                    : AppStyles.tsprimaryGrayishBlackMedium20,
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.0102,
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.6377,
            child: Text(
              "Master finance in simple way. Choose one to get started. You can switch anytime.",
              style: Get.isDarkMode
                  ? AppStyles.tsGreyRegular14
                  : AppStyles.tsGreyRegular14,
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.0306,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Embark on a learning path",
                style: Get.isDarkMode
                    ? AppStyles.tsprimarywhiteMedium18
                    : AppStyles.tsprimaryGrayishBlackMedium18,
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.0306,
          ),
          customCard(
            context: context,
            title: 'Future & Options',
            image: AppImages.virtualTrade,
            text: "Master Future & Options and Upscale your trading skills",
            onPressed: () {
              Get.find<VirtualTradingController>().loadData();
              // Get.find<VirtualTradingController>().selectedTabBarIndex(0);
              Get.to(() => VirtualTradingView());
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.0306,
          ),
          customCard(
            context: context,
            title: 'Stocks',
            image: AppImages.stock,
            text: "Master essential skills in Stock trading",
            onPressed: () {
              Get.find<StocksTradingController>().loadData();
              // Get.find<VirtualTradingController>().selectedTabBarIndex(0);
              Get.to(() => StocksDashboardView());
            },
          ),
        ],
      ),
    );
  }

  Widget customCard({
    required String title,
    required String image,
    required VoidCallback onPressed,
    required BuildContext context,
    required String text,
  }) {
    bool isComingSoonCard = title.toLowerCase() == '';

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: CommonCard(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          hasBorder: isComingSoonCard ? false : true,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              title,
                              style: Theme.of(context).textTheme.tsMedium16,
                            ),
                            SizedBox(height: 6),
                            Text(
                              text,
                              style: AppStyles.tsGreyRegular12,
                              softWrap: true,
                            ),
                            SizedBox(height: 25),
                            Text(
                              'Start Now',
                              style: TextStyle(color: AppColors.lightGreen),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        height: 90,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset(
                          image,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isComingSoonCard)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            // color: Colors.grey,
                            ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                // if (isComingSoonCard)
                //   Positioned(
                //     top: -10,
                //     left: 40,
                //     child: Container(
                //       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                //       decoration: BoxDecoration(
                //         color: AppColors.brandYellow,
                //         borderRadius: BorderRadius.circular(4),
                //       ),
                //       child: Text(
                //         "Coming Soon",
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 12,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //   ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
