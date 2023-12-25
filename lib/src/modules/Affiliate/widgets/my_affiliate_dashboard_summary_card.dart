import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';
import 'package:stoxhero/src/core/core.dart';

class MyAffilateDashboardSummary extends GetView<AffiliateController> {
  const MyAffilateDashboardSummary({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return CommonCard(
      margin: EdgeInsets.all(0).copyWith(bottom: 0, top: 8),
      children: [
        Center(
          child: Column(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  // color: AppColors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.grey.withOpacity(.25),
                  ),
                ),
                child: ClipOval(
                  child: controller.userDetails.value.profilePhoto == null
                      ? Padding(
                          padding: EdgeInsets.all(2),
                          child: Image.asset(
                            Get.isDarkMode
                                ? AppImages.darkAppLogo
                                : AppImages.lightAppLogo,
                            fit: BoxFit.cover,
                          ))
                      : Image.network(
                          controller.userDetails.value.profilePhoto?.url ?? '',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                controller.getUserFullName(),
                style: Theme.of(context).textTheme.tsMedium18,
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: signUpCard(
                      context,
                      label: 'Lifetime Earnings',
                      earning:
                          "${FormatHelper.formatNumbers("100", decimal: 0)}",
                      valueColor: AppColors.success,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: signUpCard(
                      context,
                      label: 'Total Referrals',
                      earning: "100",
                      valueColor: AppColors.black,
                      labelColor: AppColors.brandYellow,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: signUpCard(
                      context,
                      label: 'Active Referrals',
                      earning: "100",
                      valueColor: AppColors.black,
                      labelColor: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: signUpCard(
                      context,
                      label: 'Paid Referrals',
                      earning: "100",
                      valueColor: AppColors.black,
                      labelColor: AppColors.lightGreen,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: signUpCard(
                      context,
                      label: 'Total/Active',
                      earning: "3%",
                      valueColor: AppColors.black,
                      labelColor: AppColors.secondary,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: signUpCard(
                      context,
                      label: 'Total/Paid',
                      earning: "1.5%",
                      valueColor: AppColors.black,
                      labelColor: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: signUpCard(
                      context,
                      label: 'Amount/Referral',
                      earning:
                          "${FormatHelper.formatNumbers("100", decimal: 0)}",
                      valueColor: AppColors.success,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: signUpCard(
                      context,
                      label: 'Commission %',
                      earning: "12%",
                      valueColor: AppColors.black,
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

Widget signUpCard(
  BuildContext context, {
  required String label,
  required String earning,
  Color? valueColor,
  Color? labelColor,
}) {
  return CommonCard(
    margin: EdgeInsets.zero,
    children: [
      Container(
        height: 40, // Set a fixed height or use constraints to limit the height
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  label,
                  style: Theme.of(context)
                      .textTheme
                      .tsRegular14
                      .copyWith(color: labelColor),
                ),
              ),
            ),
            SizedBox(height: 4),
            Text(
              earning,
              style: Theme.of(context).textTheme.tsMedium16.copyWith(
                    color: valueColor,
                  ),
            ),
          ],
        ),
      ),
    ],
  );
}
