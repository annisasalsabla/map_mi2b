import 'package:google_maps_flutter/google_maps_flutter.dart';

class HotelInfo {
  final String id;
  final String name;
  final String imagePath;
  final LatLng location;
  final double rating;
  final String price;
  final String description;

  HotelInfo({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.location,
    required this.rating,
    required this.price,
    required this.description,
  });
}
