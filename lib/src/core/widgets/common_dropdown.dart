import 'package:flutter/material.dart';
import 'package:stoxhero/src/core/core.dart';

class CommonDropdown extends StatefulWidget {
  const CommonDropdown({Key? key}) : super(key: key);

  @override
  _CommonDropdownState createState() => _CommonDropdownState();
}

class _CommonDropdownState extends State<CommonDropdown> {
  bool isExpanded = false;
  String selectOption = 'College Name';
  List<String> collegeList = [
    'VIVA',
    'KJ',
    'DJ',
    'NMIS',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Container(
            height: 48,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.grey.withOpacity(.25),
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectOption,
                    style: AppStyles.tsGreyMedium14,
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                    color: AppColors.grey,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (isExpanded)
          Container(
            height: 160,
            child: ListView.builder(
              itemCount: collegeList.length,
              itemBuilder: (context, index) {
                final context = collegeList[index];
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectOption = context;
                          isExpanded = false;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          context,
                          style: AppStyles.tsGreyMedium14,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
