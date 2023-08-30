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
                      SizedBox(height: 16),
                      Image.asset(
                        item.image,
                        width: 250,
                        height: 250,
                      ),
                      Spacer(),
                      Text(
                        item.title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.tsMedium20,
                      ),
                      SizedBox(height: 24),
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
              width: 250,
              height: 52,
              label: (currentIndex == contents.length - 1 ? 'Get Started' : 'Next'),
              bgColor: AppColors.primary,
              onPressed: navigateToNextScreen,
            )
          else
            SizedBox(
              height: 52,
              child: FittedBox(
                child: FloatingActionButton(
                  elevation: 0,
                  backgroundColor: AppColors.primary,
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
        color: currentIndex == index ? AppColors.secondary : AppColors.grey.withOpacity(.25),
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
  OnBoardingContent(
    image: 'assets/images/onboarding1.png',
    title: 'Learn with \n Virtual Trade',
    description: 'Explore the world of investing risk-free \n by practicing with virtual money.',
  ),
  OnBoardingContent(
    image: 'assets/images/onboarding2.png',
    title: 'Battle Ground',
    description: 'Enter trading battles, show your skills, and win \n exciting gifts and cash prizes!',
  ),
  OnBoardingContent(
    image: 'assets/images/onboarding3.png',
    title: 'Contests',
    description: "Trade in our virtual contest, earn real cash \n rewards based on your portfolio's value!",
  ),
  OnBoardingContent(
    image: 'assets/images/onboarding4.png',
    title: 'Earn Real Money \n with 10x Trading',
    description: 'Harness your knowledge to fuel financial \n growth with strategic investments.',
  ),
  OnBoardingContent(
    image: 'assets/images/onboarding5.png',
    title: 'Grow Together \n with Referral',
    description: 'Gather your friends, claim rewards, and \n conquer milestones together!',
  ),
];
