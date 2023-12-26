import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';

import 'package:flutter/material.dart';
import '../../../app/app.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

class UpcomingMarginXShareModalContent extends GetView<ContestController> {
  final UpcomingMarginX? marginx;
  const UpcomingMarginXShareModalContent({
    this.marginx,
    Key? key,
  }) : super(key: key);

  Future<void> _captureAndSharePng(GlobalKey cardKey) async {
    RenderRepaintBoundary boundary =
        cardKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 5);
    ByteData byteData =
        (await image.toByteData(format: ui.ImageByteFormat.png))!;

    Uint8List pngBytes = byteData.buffer.asUint8List();

    Directory tempDir = await getTemporaryDirectory();
    File imgFile = File('${tempDir.path}/share_image.png');
    await imgFile.writeAsBytes(pngBytes);

    Share.shareFiles([imgFile.path], text: getShareMessage());
  }

  String getShareMessage() {
    return "Hey!! \n\nI just joined the ${marginx?.marginXName} MarginX on StoxHero.\n\nShow your trading skills and earn reward based on your ROI. Let's see how  big you can win!!\n\nSignup now to get ${FormatHelper.formatNumbers("100", decimal: 0)} in your StoxHero wallet.\n\nDownload the App:\nhttps://play.google.com/store/apps/details?id=com.stoxhero.app&pli=1";
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey cardKey = GlobalKey();
    return Container(
        height: 700,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.only(top: 160),
        child: Column(
          // shrinkWrap: true,

          children: [
            RepaintBoundary(
              key: cardKey,
              child: Container(
                width: double.infinity,
                child: CommonCard(
                  hasBorder: true,
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppImages
                              .testZoneShareBackground), // Replace with your image path
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                AppImages.lightAppName,
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
                                    'Test Your Trading Skills',
                                    style: AppStyles.tsSecondaryMedium24
                                        .copyWith(color: AppColors.warning),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Join ${marginx?.marginXName}"
                                        .capitalize
                                        .toString(),
                                    style: AppStyles.tsSecondaryMedium16
                                        .copyWith(color: AppColors.white),
                                  )
                                ],
                              ),
                              // SizedBox(
                              //   height: 6,
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Text(
                              //       // "& Earn upto ${controller.getPaidCapAmount(marginx?.entryFee == 0 ? marginx?.portfolio?.portfolioValue ?? 0 : marginx?.entryFee ?? 0, marginx?.payoutCapPercentage ?? 0)}",
                              //       "",
                              //       style: AppStyles.tsSecondaryMedium16
                              //           .copyWith(color: AppColors.white),
                              //     )
                              //   ],
                              // ),
                              SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Start Time",
                                            style: AppStyles
                                                .tsSecondaryRegular14
                                                .copyWith(
                                                    color: AppColors.white)),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            // "${completedContestPnl?.rank == null ? "-" : completedContestPnl?.rank}",
                                            "${FormatHelper.formatDateTimeWithoutYearToIST(marginx?.startTime)}",
                                            style: AppStyles.tsSecondaryMedium16
                                                .copyWith(
                                                    color: AppColors.white))
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text("End Time",
                                            style: AppStyles
                                                .tsSecondaryRegular14
                                                .copyWith(
                                                    color: AppColors.white)),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            '${FormatHelper.formatDateTimeWithoutYearToIST(marginx?.endTime)}',
                                            style: AppStyles.tsSecondaryMedium16
                                                .copyWith(
                                                    color: AppColors.white))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 150,
                                child: Divider(
                                  height: 1,
                                  thickness: 2,
                                  color: AppColors.white,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Entry Fee",
                                            style: AppStyles
                                                .tsSecondaryRegular14
                                                .copyWith(
                                                    color: AppColors.white)),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            marginx?.marginXTemplate
                                                        ?.entryFee ==
                                                    0
                                                ? 'Free'
                                                : FormatHelper.formatNumbers(
                                                    marginx?.marginXTemplate
                                                        ?.entryFee,
                                                    decimal: 0),
                                            style: AppStyles.tsSecondaryMedium16
                                                .copyWith(
                                                    color: AppColors.white))
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Reward",
                                          style: AppStyles.tsSecondaryRegular14
                                              .copyWith(
                                            color: AppColors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            // "${marginx?.payoutPercentage}% of Net P&L",
                                            'As Per Your ROI',
                                            style: AppStyles.tsSecondaryMedium16
                                                .copyWith(
                                                    color: AppColors.white))
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Virtual Margin",
                                          style: AppStyles.tsSecondaryRegular14
                                              .copyWith(
                                            color: AppColors.white,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            FormatHelper.formatNumbers(
                                                marginx?.marginXTemplate
                                                    ?.portfolioValue,
                                                decimal: 0),
                                            style: AppStyles.tsSecondaryMedium16
                                                .copyWith(
                                                    color: AppColors.white))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Stock market seekhna hai to ',
                                          style: AppStyles.tsSecondaryRegular14
                                              .copyWith(color: AppColors.white),
                                        ),
                                        WidgetSpan(
                                          child: Image.asset(
                                            AppImages.lightAppName,
                                            height: 16,
                                            width: 70,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' aa jao',
                                          style: AppStyles.tsSecondaryRegular14
                                              .copyWith(color: AppColors.white),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 4),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 6),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return AppColors.darkGreen; // Color when pressed
                        }
                        return AppColors.lightGreen; // Default color
                      },
                    ),
                  ),
                  onPressed: () {
                    _captureAndSharePng(cardKey);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        'Share With Friends',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
            ),
          ],
        ));
  }
}
