import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final String title;
  final int value;
  final int maxValue;
  final Color color;

  const ProgressBar({
    super.key,
    required this.title,
    required this.value,
    required this.maxValue,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    double percentage = value / maxValue;

    // BUNGKUS DENGAN CARD
    return Card(
      elevation: 2,
      // Menggunakan rounded border yang sama dengan DonutChart
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0), // Padding internal untuk konten
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title, 
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                ),
                // Pastikan format teks nilai sesuai dengan gambar (value/maxValue)
                Text(
                  '$value/$maxValue',
                  // Menggunakan warna yang sama untuk nilai seperti pada progress bar
                  style: TextStyle(color: color, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 5),
            // Progress Bar
            LinearProgressIndicator(
              value: percentage,
              minHeight: 10,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(color),
              // Tambahkan Border Radius pada progress bar agar ujungnya melengkung
              borderRadius: BorderRadius.circular(5), 
            ),
          ],
        ),
      ),
    );
  }
}
