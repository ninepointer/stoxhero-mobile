import 'package:flutter/material.dart';
import 'package:stoxhero/src/app/app.dart';

class CourseFAQSWidget extends StatefulWidget {
  final index;
  final Faqs? faqs;

  CourseFAQSWidget(this.index, this.faqs);

  @override
  State<CourseFAQSWidget> createState() => _CourseFAQSWidgetState();
}

class _CourseFAQSWidgetState extends State<CourseFAQSWidget> {
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
            Flexible(
              child: Text(
                widget.faqs?.question ?? '',
                style: AppStyles.tsSecondaryRegular16,
              ),
            ),
            Icon(
              expandedIndex == widget.index
                  ? Icons.expand_less_rounded
                  : Icons.expand_more_rounded,
              color: AppColors.grey,
            ),
          ],
        ),
        if (expandedIndex == widget.index)
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.width * 0.0408),
              Text(
                widget.faqs?.answer ?? '',
                style: Theme.of(context).textTheme.tsRegular14,
              ),
            ],
          ),
      ],
    );
  }
}
