import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stoxhero/src/app/app.dart';
import 'package:stoxhero/src/core/core.dart';

class FutureAndOptionDashBoard extends StatelessWidget {
  const FutureAndOptionDashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Embark on a learning path",
                style: Get.isDarkMode
                    ? AppStyles.tsprimarywhiteMedium14
                    : AppStyles.tsprimaryGrayishBlackMedium14,
              )
            ],
          ),
          SizedBox(
            height: 25,
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
            height: 20,
          ),
          customCard(
            context: context,
            title: 'Stocks',
            image: AppImages.stock,
            text: "Master essential skills in Stock trading",
            onPressed: () {},
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
    bool isComingSoonCard = title.toLowerCase() == 'stocks';

    return GestureDetector(
      onTap: onPressed,
      child: CommonCard(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
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
                            style: Theme.of(context).textTheme.tsMedium14,
                          ),
                          SizedBox(height: 6),
                          Text(
                            text,
                            style: AppStyles.tsGreyRegular12,
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      height: 120,
                      width: 100,
                      decoration: BoxDecoration(
                        // color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset(
                        image,
                        // height: 120,
                        // width: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              if (isComingSoonCard)
                Positioned(
                  top: -10,
                  left: 40,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.lightGreen,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "Coming Soon",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
