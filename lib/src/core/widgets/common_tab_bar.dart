import '../../app/app.dart';
import 'package:flutter/material.dart';

class CommonTabBar extends StatefulWidget {
  final bool isScrollable;
  final List<String> tabsTitle;
  final List<Widget>? tabs;
  final bool isExpanded;
  final TabController? controller;
  final int index;
  final Function(int)? onTap;
  const CommonTabBar({
    super.key,
    this.isScrollable = false,
    this.isExpanded = true,
    required this.tabsTitle,
    this.tabs,
    this.controller,
    this.index = 0,
    this.onTap,
  });

  @override
  State<CommonTabBar> createState() => _CommonTabBarState();
}

class _CommonTabBarState extends State<CommonTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.index,
      length: widget.tabsTitle.length,
      child: Column(
        children: [
          Container(
            height: 50,
            width: double.infinity,
            padding: EdgeInsets.all(8).copyWith(top: 0),
            color: Theme.of(context).cardColor,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.grey.withOpacity(.25),
              ),
              child: TabBar(
                controller: widget.controller,
                isScrollable: widget.isScrollable,
                labelColor: AppColors.white,
                unselectedLabelColor:
                    Theme.of(context).textTheme.bodyLarge!.color,
                splashBorderRadius: BorderRadius.circular(50),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Get.isDarkMode
                      ? AppColors.darkGreen
                      : AppColors.lightGreen,
                ),
                labelStyle: Theme.of(context).textTheme.tsFontFamily,
                tabs:
                    widget.tabsTitle.map((label) => Tab(text: label)).toList(),
                onTap: widget.onTap,
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: widget.tabs == null
                  ? []
                  : widget.tabs!.map((child) => child).toList(),
            ),
          )
        ],
      ),
    );
  }
}
