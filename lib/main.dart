import 'package:firebase_core/firebase_core.dart';
import 'package:flood_detection/flood_detection_app.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const FloodDetectionApp());
}
