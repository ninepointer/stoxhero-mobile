import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';

class CourseTopicsAndSubTopicsWidget extends StatefulWidget {
  final index;
  final CourseContent? courseContent;

  CourseTopicsAndSubTopicsWidget(this.index, this.courseContent);

  @override
  State<CourseTopicsAndSubTopicsWidget> createState() =>
      _CourseTopicsAndSubTopicsWidgetState();
}

class _CourseTopicsAndSubTopicsWidgetState
    extends State<CourseTopicsAndSubTopicsWidget> {
  int expandedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return CommonCard(
      margin: EdgeInsets.only(bottom: 8),
      onTap: () {
        setState(() {
          expandedIndex = expandedIndex == widget.index ? -1 : widget.index;
        });
      },
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.courseContent?.topic ?? '',
              style: AppStyles.tsSecondaryRegular16
                  .copyWith(color: AppColors.lightGreen),
            ),
            (widget.courseContent?.subtopics?.length ?? 0) > 0
                ? Icon(
                    expandedIndex == widget.index
                        ? Icons.expand_less_rounded
                        : Icons.expand_more_rounded,
                    color: AppColors.grey,
                  )
                : SizedBox()
          ],
        ),
        if (expandedIndex == widget.index)
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.courseContent!.subtopics!
                  .map(
                    (value) => Text(
                      "- ${value.topic}",
                      style: Theme.of(context).textTheme.tsRegular14,
                      textAlign: TextAlign.start,
                    ),
                  )
                  .toList()),
      ],
    );
  }
}
