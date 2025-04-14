import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wisma Ayank")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            'https://via.placeholder.com/400x200',
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Wisma Ayank", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text("Rp. 150.000", style: TextStyle(fontSize: 16, color: Colors.grey)),
                SizedBox(height: 16),
                Text(
                  "Wisma Ayank adalah penginapan nyaman dan terjangkau di pusat kota. Cocok untuk wisatawan maupun pelancong bisnis. Fasilitas lengkap, akses mudah ke pusat kuliner dan belanja.",
                  style: TextStyle(fontSize: 14),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
