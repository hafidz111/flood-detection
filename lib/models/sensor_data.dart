class SensorData {
  final String floodStatus;
  final int rainSensorValue;
  final int temperature;
  final int humidity;
  final int distance;

  SensorData({
    required this.floodStatus,
    required this.rainSensorValue,
    required this.temperature,
    required this.humidity,
    required this.distance,
  });
}
