import 'package:flutter/material.dart';

import '../models/sensor_data.dart';

class SensorProvider with ChangeNotifier {
  SensorData _currentSensorData = SensorData(
    floodStatus: 'Good',
    rainSensorValue: 364,
    temperature: 28,
    humidity: 86,
    distance: 451,
  );

  SensorData get currentSensorData => _currentSensorData;

  void simulateSensorUpdate({required String newStatus}) {
    _currentSensorData = SensorData(
      floodStatus: newStatus,
      rainSensorValue: _currentSensorData.rainSensorValue + 10,
      temperature: _currentSensorData.temperature,
      humidity: _currentSensorData.humidity,
      distance: _currentSensorData.distance,
    );
    notifyListeners();
  }
}
