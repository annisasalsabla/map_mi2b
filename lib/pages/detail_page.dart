import 'package:flutter/material.dart';
import '../model/model_data_hotel.dart';

class DetailPage extends StatelessWidget {
  final HotelInfo hotel;

  const DetailPage({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(hotel.name)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(hotel.imagePath),
            ),
            SizedBox(height: 12),

            // Nama hotel
            Text(
              hotel.name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            // Rating di bawahnya, rata kanan
            Align(
              alignment: Alignment.centerRight,
              child: StarRating(rating: hotel.rating),
            ),

            SizedBox(height: 4),
            Text(hotel.price, style: TextStyle(fontSize: 18)),
            SizedBox(height: 12),
            Text(hotel.description, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final double rating;
  final double iconSize;

  const StarRating({super.key, required this.rating, this.iconSize = 20});

  @override
  Widget build(BuildContext context) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;
    int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(rating.toStringAsFixed(1),
            style: TextStyle(fontSize: iconSize * 0.85)),
        SizedBox(width: 4),
        ...List.generate(fullStars,
                (index) => Icon(Icons.star, color: Colors.amber, size: iconSize)),
        if (hasHalfStar)
          Icon(Icons.star_half, color: Colors.amber, size: iconSize),
        ...List.generate(emptyStars,
                (index) => Icon(Icons.star_border, color: Colors.amber, size: iconSize)),
      ],
    );
  }
}
