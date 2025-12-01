import 'package:flutter/material.dart';

import '../models/history_item.dart';

class HistoryProvider with ChangeNotifier {
  final List<HistoryItem> _history = [
    HistoryItem(date: '11 September 2025', status: 'Good'),
    HistoryItem(date: '09 September 2025', status: 'Warning'),
    HistoryItem(date: '09 September 2025', status: 'Danger'),
  ];

  List<HistoryItem> get history => [..._history];

  void addHistory(String status) {
    String currentDate = '01 December 2025';

    _history.insert(0, HistoryItem(date: currentDate, status: status));
    notifyListeners();
  }
}
