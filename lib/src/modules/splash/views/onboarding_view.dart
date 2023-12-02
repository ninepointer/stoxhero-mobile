import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  int currentIndex = 0;
  late PageController? _pageController;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  void navigateToNextScreen() {
    if (currentIndex == contents.length - 1) {
      navigateToSignin();
    } else {
      _pageController?.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void navigateToSignin() {
    AppStorage.setNewUserStatus(false);
    Get.offAllNamed(AppRoutes.signin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: contents.length,
              onPageChanged: (int index) {
                currentIndex = index;
                setState(() {});
              },
              itemBuilder: (_, index) {
                var item = contents[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 48,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 36),
                      Image.asset(
                        item.image,
                        width: 250,
                        height: 195,
                      ),
                      Spacer(),
                      Text(
                        item.title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.tsMedium20,
                      ),
                      SizedBox(height: 20),
                      Text(
                        item.description,
                        textAlign: TextAlign.center,
                        style: AppStyles.tsGreyRegular16,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 36),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index),
              ),
            ),
          ),
          SizedBox(height: 36),
          if (currentIndex == contents.length - 1)
            CommonFilledButton(
              backgroundColor:
                  Get.isDarkMode ? AppColors.darkGreen : AppColors.lightGreen,
              width: 250,
              height: 52,
              label: (currentIndex == contents.length - 1
                  ? 'Get Started'
                  : 'Next'),
              onPressed: navigateToNextScreen,
            )
          else
            SizedBox(
              height: 52,
              child: FittedBox(
                child: FloatingActionButton(
                  elevation: 0,
                  backgroundColor: Get.isDarkMode
                      ? AppColors.darkGreen
                      : AppColors.lightGreen,
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.white,
                  ),
                  onPressed: navigateToNextScreen,
                ),
              ),
            ),
          SizedBox(height: 42),
          TextButton(
            onPressed: navigateToSignin,
            child: Text(
              currentIndex == contents.length - 1 ? '' : 'Skip',
              style: AppStyles.tsGreyMedium16,
            ),
          ),
          SizedBox(height: 36),
        ],
      ),
    );
  }

  Container buildDot(int index) {
    return Container(
      alignment: Alignment.center,
      height: 8,
      width: currentIndex == index ? 24 : 8,
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: currentIndex == index
            ? AppColors.secondary
            : AppColors.grey.withOpacity(.25),
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}

class OnBoardingContent {
  String image;
  String title;
  String description;

  OnBoardingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

List<OnBoardingContent> contents = [
  // OnBoardingContent(
  //   image: 'assets/images/onboarding2.png',
  //   title: 'Battle Ground',
  //   description: 'Enter trading battles, show your skills, and win \n exciting gifts and cash prizes!',
  // ),
  OnBoardingContent(
    image: AppImages.virtualTrade,
    title: 'Experience the real F&O market',
    description:
        'Participate in different TestZones to test your strategies & win cash rewards!',
  ),
  OnBoardingContent(
    image: AppImages.workshop,
    title: 'Future & Options (F&O)',
    description:
        "Learn the basics of options trading by executing your strategies for free!",
  ),
  OnBoardingContent(
    image: AppImages.tenx,
    title: 'Subscribe to StoxHero TenX plans',
    description:
        'Subscribe to TenX plans and apply your learning to earn cash reward!',
  ),
  OnBoardingContent(
    image: AppImages.job,
    title: 'Get your real market readiness tested!',
    description:
        'Participate in MarginX with virtual money at a very low investment and check your market readiness!',
  ),
  OnBoardingContent(
    image: AppImages.referral,
    title: 'Refer your friends and win ',
    description:
        'Refer your friend & get \u{20B9}15 in your StoxHero wallet, your friend gets \u{20B9}100 as signup bonus',
  ),
  OnBoardingContent(
    image: AppImages.contestLeaderboard,
    title: 'Check TestZone Weekly Earning Leaderboard',
    description:
        'Check the TestZone profiles of top TestZone traders of the week along with their recent TestZone participations!',
  ),
];
