import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/app.dart';

class LiveMarginxCard extends GetView<MarginXController> {
  final LiveMarginX? marginx;
  LiveMarginxCard({Key? key, this.marginx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      padding: EdgeInsets.zero,
      children: [
        Container(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  // padding: const EdgeInsets.symmetric(horizontal: 12),
                  padding: EdgeInsets.only(
                    left: 12,
                    right: 12,
                    top: 8,
                  ),
                  child: Text(
                    marginx?.marginXName ?? '',
                    style: AppStyles.tsSecondaryMedium14,
                  ),
                ),
              ),
              //    IconButton(
              //   onPressed: () {
              //     BottomSheetHelper.openBottomSheet(
              //       context: context,
              //       child: MarginxInfoBottomSheet(),
              //     );
              //   },
              //   icon: Icon(
              //     Icons.info_outline_rounded,
              //     size: 20,
              //   ),
              // ),
              Container(
                height: 15, // Adjust the height as needed
                child: InkWell(
                  onTap: () {
                    BottomSheetHelper.openBottomSheet(
                      context: context,
                      child: MarginxInfoBottomSheet(),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.info,
                      size: 20.0,
                      color: Colors.grey, // Icon color
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: [
              Visibility(
                visible: marginx?.isNifty == true,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text(
                    'Nifty',
                    style: AppStyles.tsGreyMedium12,
                  ),
                ),
              ),
              SizedBox(width: 4),
              Visibility(
                visible: marginx?.isBankNifty == true,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text(
                    'Bank Nifty',
                    style: AppStyles.tsGreyMedium12,
                  ),
                ),
              ),
              SizedBox(width: 4),
              Visibility(
                visible: marginx?.isFinNifty == true,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text(
                    'Finnifty',
                    style: AppStyles.tsGreyMedium12,
                  ),
                ),
              ),
              SizedBox(width: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Text(
                  'Day',
                  style: AppStyles.tsGreyMedium12,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Padding(padding: EdgeInsets.only(left: 0)),
            Image.asset(
              AppImages.contestTrophy,
              width: 30,
              height: 20,
            ),
            Text(
              '% of your Investment',
              style: Theme.of(context).textTheme.tsMedium12,
            ),
          ],
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Virtual Margin',
                        style: Theme.of(context).textTheme.tsGreyMedium12,
                      ),
                      SizedBox(height: 2),
                      Text(
                        FormatHelper.formatNumbers(
                            marginx?.marginXTemplate?.portfolioValue,
                            decimal: 0),
                        style: Theme.of(context).textTheme.tsMedium12,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Started',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Entry Fee',
                        style: Theme.of(context).textTheme.tsGreyMedium12,
                      ),
                      SizedBox(height: 2),
                      Text(
                        FormatHelper.formatNumbers(
                            marginx?.marginXTemplate?.entryFee,
                            decimal: 0),
                        style: Theme.of(context).textTheme.tsMedium12,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Starts:',
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Rubik')),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                          FormatHelper.formatDateTimeWithoutYearToIST(
                              marginx?.startTime),
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Rubik')),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Spots left:',
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Rubik')),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                          controller
                              .calculateSeatsLeft(
                                marginx?.maxParticipants ?? 0,
                                marginx?.participants?.length ?? 0,
                              )
                              .toString(),
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Rubik')),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Ends:',
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Rubik')),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                          FormatHelper.formatDateTimeWithoutYearToIST(
                              marginx?.endTime),
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Rubik')),
                    ],
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(bottom: 8)),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  controller.liveMarginX(marginx);
                  Get.to(
                    () => ViewCard(liveMarginX: marginx),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(.25),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    'View Details',
                    style: AppStyles.tsWhiteMedium12.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: controller.checkIfLivePurchased(marginx)
                    ? () {
                        controller.loadTradingData();
                        controller.liveMarginX(marginx);
                        Get.to(() => MarginXTradingView());
                      }
                    : () {
                        if (controller.calculateSeatsLeft(
                                marginx?.maxParticipants ?? 0,
                                marginx?.participants?.length ?? 0) ==
                            0) {
                          SnackbarHelper.showSnackbar('Marginx is Full');
                        } else {
                          BottomSheetHelper.openBottomSheet(
                            context: context,
                            child: PaymentBottomSheet(
                              productType: ProductType.marginx,
                              productId: marginx?.id ?? '',
                              buyItemPrice:
                                  marginx?.marginXTemplate?.entryFee ?? 0,
                              onPaymentSuccess:
                                  controller.loadDataAfterPaymentSuccess,
                              onSubmit: () {
                                Get.back();
                                var walletController =
                                    Get.find<WalletController>();
                                var data = {
                                  "bonusRedemption": 0,
                                  "coupon": walletController
                                      .couponCodeTextController.text,
                                  "entryFee":
                                      walletController.subscriptionAmount.value,
                                  "marginXId": marginx?.id,
                                  "marginXName": marginx?.marginXName,
                                };
                                controller.purchaseMarginX(data);
                              },
                            ),
                          );
                        }
                      },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(.25),
                  ),
                  child: Text(
                    controller.checkIfLivePurchased(marginx) &&
                            controller.calculateSeatsLeft(
                                    marginx?.maxParticipants ?? 0,
                                    marginx?.participants?.length ?? 0) >
                                0
                        ? 'Start Trading'
                        : 'Join Now',
                    style: AppStyles.tsWhiteMedium12.copyWith(
                      color: AppColors.success,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  controller.liveMarginX(marginx);
                  controller.getShareMarginX(false);
                  String url = 'https://stoxhero.com/marginxs';
                  Clipboard.setData(ClipboardData(text: url));
                  SnackbarHelper.showSnackbar(
                      'Link Copied, Share with your friends.');
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(.25),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Share',
                    style: AppStyles.tsWhiteMedium12.copyWith(
                      color: AppColors.secondary.shade600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
