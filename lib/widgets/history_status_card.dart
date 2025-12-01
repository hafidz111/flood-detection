import 'package:flutter/material.dart';

class HistoryStatusCard extends StatelessWidget {
  final String date;
  final String status;

  const HistoryStatusCard({
    super.key,
    required this.date,
    required this.status,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Good':
        return Colors.lightGreen;
      case 'Warning':
        return Colors.amber[700]!;
      case 'Danger':
        return Colors.red[700]!;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color statusColor = _getStatusColor(status);

    const double fixedStatusWidth = 90.0;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(date, style: const TextStyle(fontSize: 16)),

            SizedBox(
              width: fixedStatusWidth,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: (status == 'Good' || status == 'Warning')
                        ? Colors.black
                        : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
