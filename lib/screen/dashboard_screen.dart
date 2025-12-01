import 'package:flood_detection/widgets/flood_status_panel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/sensor_provider.dart';
import '../providers/history_provider.dart';
import '../widgets/donut_chart.dart';
import '../widgets/progress_bar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SensorProvider>(
      builder: (context, sensorData, child) {
        final data = sensorData.currentSensorData;
        const maxRainSensor = 500;
        const maxDistance = 500;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Flood Status Visual
              FloodStatusPanel(status: data.floodStatus),
              
              // 2. Sensor Gauges (Rain & Temperature) menggunakan DonutChart
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DonutChart(
                    title: 'Rain Sensor',
                    value: data.rainSensorValue,
                    maxValue: maxRainSensor,
                    color: Colors.red[800]!,
                    unit: '',
                  ),
                  DonutChart(
                    title: 'Temperature',
                    value: data.temperature,
                    maxValue: 50,
                    color: Colors.blue[600]!,
                    unit: ' C',
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // 3. Humidity (%) menggunakan ProgressBar
              ProgressBar(
                title: 'Humidity (%)',
                value: data.humidity,
                maxValue: 100,
                color: Colors.blue,
              ),
              
              const SizedBox(height: 10),

              // 4. Distance (CM) menggunakan ProgressBar
              ProgressBar(
                title: 'Distance (CM)',
                value: data.distance,
                maxValue: maxDistance,
                color: Colors.pink,
              ),

              const SizedBox(height: 30),
              
              // 5. Capture History Button
              ElevatedButton(
                onPressed: () {
                  Provider.of<HistoryProvider>(context, listen: false)
                      .addHistory(data.floodStatus);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('History Captured: ${data.floodStatus}'))
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004D7A),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Capture History',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
