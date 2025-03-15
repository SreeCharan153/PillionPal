import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  final int maxStars;
  final double size;
  final Color color;
  final Function(int) onRatingSelected;

  const StarRating({
    super.key,
    this.maxStars = 5,
    this.size = 40,
    this.color = Colors.amber,
    required this.onRatingSelected,
  });

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  int _selectedStars = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.maxStars, (index) {
        return IconButton(
          icon: Icon(
            index < _selectedStars ? Icons.star : Icons.star_border,
            color: widget.color,
            size: widget.size,
          ),
          onPressed: () {
            setState(() {
              _selectedStars = index + 1;
            });
            widget.onRatingSelected(_selectedStars);
          },
        );
      }),
    );
  }
}
