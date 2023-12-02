import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core.dart';

class CommonSegmentedControl extends StatefulWidget {
  final Map<int, String> segments;
  final int selectedSegment;
  final Color? selectedColor;
  final Color? borderColor;
  final Color? unselectedColor;
  final ValueChanged<int> onValueChanged;

  CommonSegmentedControl({
    required this.segments,
    required this.selectedSegment,
    this.selectedColor,
    this.borderColor,
    this.unselectedColor,
    required this.onValueChanged,
  });

  @override
  _CommonSegmentedControlState createState() => _CommonSegmentedControlState();
}

class _CommonSegmentedControlState extends State<CommonSegmentedControl> {
  int segmentedControlValue = 0;

  @override
  void initState() {
    super.initState();
    segmentedControlValue = widget.selectedSegment;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: CupertinoSegmentedControl<int>(
        selectedColor: AppColors.lightGreen,
        borderColor: AppColors.grey.withOpacity(.25),
        unselectedColor: Colors.transparent,
        children: widget.segments.map((key, value) {
          return MapEntry(
            key,
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                value,
                style: segmentedControlValue == key
                    ? Theme.of(context).textTheme.tsRegular16.copyWith(
                          color: AppColors.white,
                        )
                    : Theme.of(context).textTheme.tsRegular16,
              ),
            ),
          );
        }),
        onValueChanged: (int val) {
          setState(() {
            segmentedControlValue = val;
            widget.onValueChanged(val);
          });
        },
        groupValue: segmentedControlValue,
      ),
    );
  }
}
