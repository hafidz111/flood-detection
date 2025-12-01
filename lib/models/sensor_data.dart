import 'package:cloud_firestore/cloud_firestore.dart';

class SensorData {
  final String floodStatus;
  final int rainSensorValue;
  final double temperature;
  final int humidity;
  final int distance;
  final String sensorId;
  final String location;

  SensorData({
    required this.floodStatus,
    required this.rainSensorValue,
    required this.temperature,
    required this.humidity,
    required this.distance,
    required this.sensorId,
    required this.location,
  });

  factory SensorData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return SensorData(
      floodStatus: data?['floodStatus'] ?? 'No Data',
      rainSensorValue: (data?['rainSensorValue'] as num?)?.toInt() ?? 0,
      temperature: (data?['temperature'] as num?)?.toDouble() ?? 0.0,
      humidity: (data?['humidity'] as num?)?.toInt() ?? 0,
      distance: (data?['distance'] as num?)?.toInt() ?? 0,
      sensorId: data?['sensor_id'] ?? '1',
      location: data?['location'] ?? 'lab_fasilkom',
    );
  }
}
