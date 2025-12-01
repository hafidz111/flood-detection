import 'package:flutter/material.dart';

class FloodStatusPanel extends StatelessWidget {
  final String status;

  const FloodStatusPanel({super.key, required this.status});

  // Fungsi untuk mendapatkan warna status utama dan border gelap
  Map<String, Color> _getStatusColors(String status) {
    switch (status) {
      case 'Good':
        return {
          'fill': const Color(0xFF6CC551),
          'border': const Color(0xFF4C9A36), // Hijau gelap
        };
      case 'Warning':
        return {
          'fill': const Color(0xFFFFAE42),
          'border': const Color(0xFFD89230), // Kuning gelap
        };
      case 'Danger':
        return {
          'fill': const Color(0xFFFC5C65),
          'border': const Color(0xFFD0444A), // Merah gelap
        };
      default:
        return {
          'fill': Colors.grey,
          'border': Colors.black54,
        };
    }
  }

  // Fungsi pembantu untuk membuat kotak warna kecil (DIPERBARUI)
  // Menerima warna fill, warna border, dan apakah kotak ini aktif
  Widget _colorBox({
    required Color color, 
    required Color borderColor, 
    required bool isActive
  }) {
    // Tentukan border hanya jika isActive bernilai true
    final borderStyle = isActive
        ? Border.all(color: borderColor, width: 3) // Border tebal (width 3)
        : Border.all(color: Colors.transparent, width: 0); // Polos (tanpa border)

    return Expanded(
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: borderStyle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Ambil data warna untuk status Good, Warning, dan Danger
    final goodColors = _getStatusColors('Good');
    final warningColors = _getStatusColors('Warning');
    final dangerColors = _getStatusColors('Danger');
    
    // Ambil warna fill untuk Container Teks Status
    final statusFillColor = _getStatusColors(status)['fill']!;

    const double cardPaddingHorizontal = 16.0;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(cardPaddingHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Flood Status',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 15),

            // KOTAK WARNA (ROW) - Menerapkan logika isActive
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Row(
                children: [
                  // Kotak Hijau: Aktif jika status == 'Good'
                  _colorBox(
                    color: goodColors['fill']!,
                    borderColor: goodColors['border']!,
                    isActive: status == 'Good',
                  ),
                  const SizedBox(width: 8),
                  // Kotak Kuning: Aktif jika status == 'Warning'
                  _colorBox(
                    color: warningColors['fill']!,
                    borderColor: warningColors['border']!,
                    isActive: status == 'Warning',
                  ),
                  const SizedBox(width: 8),
                  // Kotak Merah: Aktif jika status == 'Danger'
                  _colorBox(
                    color: dangerColors['fill']!,
                    borderColor: dangerColors['border']!,
                    isActive: status == 'Danger',
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),

            // CONTAINER STATUS TEKS
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: statusFillColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                status,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
