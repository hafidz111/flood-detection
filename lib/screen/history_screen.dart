import 'package:flood_detection/style/colors/flood_detection_colors.dart';
import 'package:flood_detection/widgets/history_status_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/history_item.dart';
import '../providers/history_provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final historyProvider = Provider.of<HistoryProvider>(
        context,
        listen: false,
      );

      if (!historyProvider.isInitialized) {
        historyProvider.fetchHistory();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final customBackgroundColor = FloodDetectionColors.backgroundLight.color;

    return Consumer<HistoryProvider>(
      builder: (context, historyProvider, child) {
        List<HistoryItem> historyList = historyProvider.history;

        if (historyProvider.isLoading && !historyProvider.isInitialized) {
          return Center(
            child: CircularProgressIndicator(color: colorScheme.primary),
          );
        }
        if (historyList.isEmpty) {
          return Center(
            child: Text(
              'No history data available.',
              style: TextStyle(color: colorScheme.onSurface),
            ),
          );
        }

        return Container(
          color: customBackgroundColor,
          child: RefreshIndicator(
            color: colorScheme.primary,
            onRefresh: () => historyProvider.fetchHistory(forceRefresh: true),
            child: ListView.builder(
              itemCount: historyList.length,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              itemBuilder: (context, index) {
                final item = historyList[index];

                return HistoryStatusCard(date: item.date, status: item.status);
              },
            ),
          ),
        );
      },
    );
  }
}
