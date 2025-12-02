import 'package:flood_detection/style/colors/flood_detection_colors.dart';
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
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface
                  ),
                ),

                Text(
                  '$value/$maxValue',

                  style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16,),
                ),
              ],
            ),
            const SizedBox(height: 5),

            LinearProgressIndicator(
              value: percentage,
              minHeight: 10,
              backgroundColor: FloodDetectionColors.disable.color,
              valueColor: AlwaysStoppedAnimation<Color>(color),

              borderRadius: BorderRadius.circular(5),
            ),
          ],
        ),
      ),
    );
  }
}
