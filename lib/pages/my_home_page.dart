import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../model/model_data_hotel.dart';
import 'detail_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MapType _mapType = MapType.normal;
  String? _styleMap;
  HotelInfo? _selectedHotel;
  Set<Marker> _markers = {};

  final List<HotelInfo> _hotels = [
    HotelInfo(
      id: 'ibis',
      name: 'Hotel Ibis Padang',
      imagePath: 'assets/image/hotel_ibis.jpg',
      location: LatLng(-0.9255793426822795, 100.36214914453444),
      rating: 4.5,
      price: 'Rp. 558.000',
      description:
      'Hotel modern di bangunan bergaya industri yang modern ini berjarak 3,5 km dari Museum Adityawarman, 3,9 km dari Masjid Raya Ganting, dan 13 km dari Pantai Air Manis.',
    ),
    HotelInfo(
      id: 'favehotel',
      name: 'Favehotel Olo Padang',
      imagePath: 'assets/image/favohotel.jpg',
      location: LatLng(-0.9418850076318459, 100.35648431947676),
      rating: 4.2,
      price: 'Rp. 404.000',
      description:
      'Hotel santai yang menawarkan pemandangan gunung ini berjarak 2 km dari Monumen Merpati Perdamaian dan 3 km dari Masjid Al-Irsyad yang berbentuk kotak.',
    ),
    HotelInfo(
      id: 'mercure',
      name: 'Hotel Mercure Padang',
      imagePath: 'assets/image/mercurehotel.jpg',
      location: LatLng(-0.9326165336703525, 100.35545435128445),
      rating: 4.5,
      price: 'Rp. 743.041',
      description:
      'Di gedung ultramodern dengan panorama sungai dan gunung, hotel ini berjarak 3 menit dari Samudra Hindia dan 4 km dari stasiun Padang.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _addMarkers();
  }

  void _addMarkers() {
    for (var hotel in _hotels) {
      _markers.add(
        Marker(
          markerId: MarkerId(hotel.id),
          position: hotel.location,
          onTap: () {
            setState(() {
              if (_selectedHotel?.id == hotel.id) {
                _selectedHotel = null;
              } else {
                _selectedHotel = hotel;
              }
            });
          },
        ),
      );
    }
  }

  Widget _buildInfoCard() {
    if (_selectedHotel == null) return SizedBox.shrink();
    final hotel = _selectedHotel!;

    return Positioned(
      top: 100,
      left: 50,
      right: 50,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  hotel.imagePath,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 8),
              Text(
                hotel.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: StarRating(rating: hotel.rating),
              ),
              SizedBox(height: 4),
              Text(hotel.price),
              SizedBox(height: 6),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailPage(hotel: hotel),
                      ),
                    );
                  },
                  child: Text('VIEW'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _loadFilesStyleMap(String path) async {
    String style = await rootBundle.loadString(path);
    setState(() => _styleMap = style);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _hotels[0].location,
              zoom: 13,
            ),
            markers: _markers,
            mapType: _mapType,
            style: _styleMap,
            onTap: (_) => setState(() => _selectedHotel = null),
          ),
          if (_selectedHotel != null) _buildInfoCard(),
          Positioned(
            bottom: 16,
            left: 16,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _mapType = _mapType == MapType.normal
                          ? MapType.satellite
                          : MapType.normal;
                    });
                  },
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.map, color: Colors.white),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: () => setState(() => _styleMap = null),
                  backgroundColor: Colors.green,
                  child: Icon(Icons.sunny, color: Colors.white),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: () =>
                      _loadFilesStyleMap('assets/style_map/style_dark.json'),
                  backgroundColor: Colors.green,
                  child: Icon(Icons.dark_mode, color: Colors.black),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: () =>
                      _loadFilesStyleMap('assets/style_map/style_retro.json'),
                  backgroundColor: Colors.green,
                  child: Icon(Icons.location_city, color: Colors.yellow),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final double rating;
  final double iconSize;

  const StarRating({super.key, required this.rating, this.iconSize = 18});

  @override
  Widget build(BuildContext context) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;
    int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(rating.toStringAsFixed(1),
            style: TextStyle(fontSize: iconSize * 0.9)),
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
