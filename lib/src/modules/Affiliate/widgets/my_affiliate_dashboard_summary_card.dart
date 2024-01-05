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
        Column(
          children: [
            Container(
              height: 80,
              width: 80,
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
            SizedBox(height: 12),
            Text(
              controller.getUserFullName(),
              style: Theme.of(context).textTheme.tsMedium18,
            ),
          ],
        )
      ],
    );
  }
}
