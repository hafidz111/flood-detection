import 'package:flood_detection/style/colors/flood_detection_colors.dart';
import 'package:flutter/material.dart';

class FloodStatusPanel extends StatelessWidget {
  final String status;

  const FloodStatusPanel({super.key, required this.status});

  Map<String, Color> _getStatusColors(String status) {
    switch (status) {
      case 'Good':
        return {
          'fill': FloodDetectionColors.floodStatusGood.color,
          'border': FloodDetectionColors.borderGood.color,
        };
      case 'Warning':
        return {
          'fill': FloodDetectionColors.floodStatusWarning.color,
          'border': FloodDetectionColors.borderWarning.color,
        };
      case 'Danger':
        return {
          'fill': FloodDetectionColors.floodStatusDanger.color,
          'border': FloodDetectionColors.borderDanger.color,
        };
      default:
        return {
          'fill': FloodDetectionColors.disableButton.color,
          'border': Colors.transparent,
        };
    }
  }

  Widget _colorBox({
    required Color color,
    required Color borderColor,
    required bool isActive,
  }) {
    final borderStyle = isActive
        ? Border.all(color: borderColor, width: 5)
        : Border.all(color: Colors.transparent, width: 0);

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
    final colorScheme = Theme.of(context).colorScheme;
    final goodColors = _getStatusColors('Good');
    final warningColors = _getStatusColors('Warning');
    final dangerColors = _getStatusColors('Danger');

    final statusFillColor = _getStatusColors(status)['fill']!;

    final statusTextColor = statusFillColor.computeLuminance() > 0.5
        ? Colors.black
        : Colors.white;

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
            Text(
              'Flood Status',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Row(
                children: [
                  _colorBox(
                    color: goodColors['fill']!,
                    borderColor: goodColors['border']!,
                    isActive: status == 'Good',
                  ),
                  const SizedBox(width: 8),

                  _colorBox(
                    color: warningColors['fill']!,
                    borderColor: warningColors['border']!,
                    isActive: status == 'Warning',
                  ),
                  const SizedBox(width: 8),

                  _colorBox(
                    color: dangerColors['fill']!,
                    borderColor: dangerColors['border']!,
                    isActive: status == 'Danger',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

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
                style: TextStyle(
                  color: statusTextColor,
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
