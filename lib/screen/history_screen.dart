import 'package:flood_detection/widgets/history_status_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/history_provider.dart';
import '../models/history_item.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryProvider>(
      builder: (context, historyProvider, child) {
        List<HistoryItem> historyList = historyProvider.history;

        if (historyList.isEmpty) {
          return const Center(child: Text('No history data available.'));
        }

        // PERBAIKAN: Mengganti ListView.separated menjadi ListView.builder 
        // dan menambahkan padding horizontal untuk tampilan seperti Card terpisah.
        return ListView.builder(
          itemCount: historyList.length,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Padding di sekitar daftar
          itemBuilder: (context, index) {
            final item = historyList[index];
            
            // Karena HistoryStatusTile sekarang adalah Card dan memiliki margin vertikal di dalamnya, 
            // ListView.builder sudah cukup untuk menampilkan daftar Card yang rapi.
            return HistoryStatusCard(
              date: item.date,
              status: item.status,
            );
          },
        );
      },
    );
  }
}
