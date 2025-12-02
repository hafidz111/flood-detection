import 'package:flood_detection/style/colors/flood_detection_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryStatusCard extends StatelessWidget {
  final DateTime date;
  final String status;

  const HistoryStatusCard({
    super.key,
    required this.date,
    required this.status,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Good':
        return FloodDetectionColors.statusSuccess.color;
      case 'Warning':
        return FloodDetectionColors.statusWarning.color;
      case 'Danger':
        return FloodDetectionColors.statusFailed.color;
      default:
        return FloodDetectionColors.disable.color;
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('d MMMM yyyy').format(date.toLocal());
  }

  @override
  Widget build(BuildContext context) {
    Color statusColor = _getStatusColor(status);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final formattedDate = _formatDate(date);
    const double fixedStatusWidth = 90.0;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(formattedDate, style: TextStyle(fontSize: 16, color: colorScheme.onSurface)),

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
                    color: FloodDetectionColors.textWhite.color,
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
