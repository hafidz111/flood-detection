import 'package:flutter/material.dart';

class DonutChart extends StatelessWidget {
  final String title;
  final int value;
  final int maxValue;
  final Color color;
  final String unit;

  const DonutChart({
    super.key,
    required this.title,
    required this.value,
    required this.maxValue,
    required this.color,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    // Pastikan persentase tidak melebihi 1.0
    double percentage = value / maxValue;
    if (percentage > 1.0) percentage = 1.0;

    // Tentukan stroke width. Di gambar: Rain Sensor terlihat lebih tebal (misal 12), Temperature lebih tipis (misal 8).
    final double strokeWidth = title.contains('Rain Sensor') ? 12 : 8;
    // Tentukan ukuran font nilai.
    final double valueFontSize = title.contains('Rain Sensor') ? 30 : 28;

    // Menentukan style berdasarkan judul
    final bool isRainSensor = title.contains('Rain Sensor');
    
    // Warna teks spesifik dari gambar
    final Color valueColor = isRainSensor 
        ? const Color(0xFF900000) // Merah tua untuk Rain Sensor
        : const Color(0xFF00798C); // Biru tua untuk Temperature
    return Expanded(
      child: Card(
        elevation: 2,
        // PENYESUAIAN: Tambahkan border radius pada Card
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                title, 
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
              ),
              const SizedBox(height: 10),
              Stack(
                alignment: Alignment.center,
                children: [
                  // AKTIFKAN ROTASI: Sudut Awal (Start Angle) ke diagonal (-45 derajat)
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      value: percentage,
                      strokeWidth: strokeWidth, 
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                    ),
                  ),
                  
                  // TEKS SATU BARIS (ROW)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$value', // Nilai Utama (misal: 28)
                        style: TextStyle(
                          fontSize: valueFontSize,
                          fontWeight: FontWeight.bold,
                          color: valueColor,
                        ),
                      ),
                      // Menambahkan unit (misal: C)
                      if (unit.isNotEmpty)
                        Text(
                          unit, 
                          style: TextStyle(
                            // Ukuran font unit dibuat lebih kecil 
                            fontSize: valueFontSize, 
                            fontWeight: FontWeight.bold,
                            color: valueColor.withOpacity(0.8),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
