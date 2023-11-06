import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

import '../../app/app.dart';

class ListViewShimmer extends StatelessWidget {
  final int? itemCount;
  final Widget? shimmerCard;
  final bool isScroll;
  final EdgeInsets? padding;

  const ListViewShimmer({
    super.key,
    this.itemCount,
    this.shimmerCard,
    this.padding,
    this.isScroll = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: !isScroll,
      physics: isScroll ? ClampingScrollPhysics() : NeverScrollableScrollPhysics(),
      padding: padding ?? EdgeInsets.all(16).copyWith(bottom: 56),
      itemCount: itemCount ?? 3,
      itemBuilder: (context, index) {
        return shimmerCard ?? MediumCardShimmer();
      },
    );
  }
}

class CustomCardShimmer extends StatelessWidget {
  final EdgeInsets? margin;
  final double? height;
  const CustomCardShimmer({
    super.key,
    this.margin,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey.withOpacity(.25),
      highlightColor: AppColors.grey.withOpacity(.5),
      child: Container(
        height: height ?? 40,
        margin: margin ?? EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: AppColors.white,
        ),
      ),
    );
  }
}

class SmallCardShimmer extends StatelessWidget {
  final EdgeInsets? margin;
  const SmallCardShimmer({super.key, this.margin});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey.withOpacity(.25),
      highlightColor: AppColors.grey.withOpacity(.5),
      child: Container(
        height: 80,
        margin: margin ?? EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: AppColors.white,
        ),
      ),
    );
  }
}

class MediumCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey.withOpacity(.25),
      highlightColor: AppColors.grey.withOpacity(.5),
      child: Container(
        height: 140,
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: AppColors.white,
        ),
      ),
    );
  }
}

class LargeCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey.withOpacity(.25),
      highlightColor: AppColors.grey.withOpacity(.5),
      child: Container(
        height: 200,
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: AppColors.white,
        ),
      ),
    );
  }
}
