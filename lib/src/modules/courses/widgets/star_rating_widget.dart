import 'package:flutter/material.dart';

class StarRatingWidget extends StatefulWidget {
  final int starCount;
  final double rating;
  final Color color;
  final double size;

  const StarRatingWidget({
    Key? key,
    this.starCount = 5,
    this.rating = 0.0,
    this.color = Colors.lightGreen,
    this.size = 10.0,
  }) : super(key: key);

  @override
  _StarRatingWidgetState createState() => _StarRatingWidgetState();
}

class _StarRatingWidgetState extends State<StarRatingWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.starCount, (index) {
        return Icon(
          index < widget.rating ? Icons.star : Icons.star_border,
          color: widget.color,
          size: widget.size,
        );
      }),
    );
  }
}
