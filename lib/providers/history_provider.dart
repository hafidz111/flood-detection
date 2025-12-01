import 'package:flutter/material.dart';
import '../models/history_item.dart';

class HistoryProvider with ChangeNotifier {
  // Dummy data History
  final List<HistoryItem> _history = [
    HistoryItem(date: '11 September 2025', status: 'Good'),
    HistoryItem(date: '09 September 2025', status: 'Warning'),
    HistoryItem(date: '09 September 2025', status: 'Danger'),
  ];

  List<HistoryItem> get history => [..._history]; // Mengembalikan copy

  // Fungsi untuk 'menangkap' history
  void addHistory(String status) {
    // Format tanggal saat ini (Simulasi)
    String currentDate = '01 December 2025'; 
    
    // Tambahkan item baru ke awal list
    _history.insert(0, HistoryItem(date: currentDate, status: status));
    notifyListeners(); // Beritahu widget yang mendengarkan (HistoryScreen)
  }
}
