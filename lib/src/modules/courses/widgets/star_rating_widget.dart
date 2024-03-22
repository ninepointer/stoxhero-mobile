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
    // Calculate the integer part of the rating
    int filledStars = widget.rating.toInt();

    // Calculate the decimal part of the rating
    double decimalPart = widget.rating - filledStars;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.starCount, (index) {
        // Check if the index is less than the integer part of the rating
        if (index < filledStars) {
          return Icon(
            Icons.star,
            color: widget.color,
            size: widget.size,
          );
        } else if (index == filledStars && decimalPart > 0) {
          // If the index equals the integer part and there is a decimal part, display a half-filled star
          return Icon(
            Icons.star_half,
            color: widget.color,
            size: widget.size,
          );
        } else {
          // Otherwise, display an empty star
          return Icon(
            Icons.star_border,
            color: widget.color,
            size: widget.size,
          );
        }
      }),
    );
  }
}
