class HistoryItem {
  final DateTime date;
  final String status;

  HistoryItem({required this.date, required this.status});

  String get formattedDate => date.toLocal().toString();
}
