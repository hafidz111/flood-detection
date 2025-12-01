import 'package:flood_detection/service/navigation_service.dart';
import 'package:flood_detection/utils/auth_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/history_provider.dart';
import 'providers/sensor_provider.dart';

class FloodDetectionApp extends StatelessWidget {
  const FloodDetectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SensorProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Flood\'nt?!',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF004D7A),
            foregroundColor: Colors.white,
          ),
          scaffoldBackgroundColor: Colors.white,
        ),
        navigatorKey: navigatorKey,
        home: const AuthWrapper(),
      ),
    );
  }
}
