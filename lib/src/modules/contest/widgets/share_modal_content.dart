import 'package:flutter/material.dart';
import '../../../app/app.dart';
import 'package:share_plus/share_plus.dart';

class ShareModalContent extends GetView<ContestController> {
  final String? id;
  final CompletedContest? contest;
  final CompletedContestPnl? completedContestPnl;

  const ShareModalContent({
    Key? key,
    this.id,
    this.contest,
    this.completedContestPnl,
  }) : super(key: key);

  String getShareMessage() {
    return "Hey!! \n\n I just won INR ${FormatHelper.formatNumbers(30)} in Monday Trident TestZone on StoxHero app.\n\nThis is a super exciting way to learn Stocks Market Trading and Win Cash rewards !!";
  }

  @override
  Widget build(BuildContext context) {
    print('Completed ${completedContestPnl?.npnl}');
    print('Completed $contest');
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          // shrinkWrap: true,
          children: [
            Container(
              width: double.infinity,
              child: CommonCard(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                children: [
                  Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            AppImages.dartAppName,
                            height: 30,
                            width: 100,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'TESTZONE',
                                style: AppStyles.tsSecondaryMedium24
                                    .copyWith(color: AppColors.lightGreen),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('MEGA WINNER',
                                  style: AppStyles.tsSecondaryMedium16
                                      .copyWith(color: AppColors.black)),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.grey.withOpacity(.25),
                                  ),
                                ),
                                child: ClipOval(
                                    child:
                                        //controller.userDetails.value.profilePhoto == null
                                        Image.asset(
                                  Get.isDarkMode
                                      ? AppImages.darkAppLogo
                                      : AppImages.lightAppLogo,
                                  fit: BoxFit.cover,
                                )
                                    // : Image.network(
                                    //     controller.userDetails.value.profilePhoto?.url ?? '',
                                    //     fit: BoxFit.cover,
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Rahul kumar Gupta',
                                  style: AppStyles.tsSecondaryMedium16
                                      .copyWith(color: AppColors.black))
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text("Rank",
                                      style: AppStyles.tsSecondaryMedium16),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text('2',
                                      style: AppStyles.tsSecondaryMedium16)
                                ],
                              ),
                              Column(
                                children: [
                                  Text("Net P&L",
                                      style: AppStyles.tsSecondaryMedium16),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                      FormatHelper.formatNumbers(199,
                                          decimal: 2),
                                      style: AppStyles.tsSecondaryMedium16)
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 150,
                            child: Divider(
                              height: 1,
                              thickness: 2,
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Contest Name',
                                  style:
                                      AppStyles.tsSecondaryRegular14.copyWith(
                                    color: AppColors.black,
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Monday Trident',
                                  style: AppStyles.tsSecondaryMedium16
                                      .copyWith(color: AppColors.black))
                            ],
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  contest?.contestEndTime != null
                                      ? FormatHelper.formatDateInMonth(
                                          contest?.contestEndTime!)
                                      : "01/12/2023",
                                  style: AppStyles.tsSecondaryMedium16
                                      .copyWith(color: AppColors.black))
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 4),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () {
                  Share.share(getShareMessage());
                  Navigator.of(context).pop();
                },
                child: Text('Share'),
              ),
            ),
          ],
        ));
  }
}
