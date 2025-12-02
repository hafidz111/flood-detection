import 'package:flutter/material.dart';

enum FloodDetectionColors {
  primaryDark("Primary Dark Blue", Color(0xFF004D7A)),

  secondaryLight("Secondary Light Blue", Color(0xFF007B9A)),

  backgroundDark("Dark Background", Color(0xFF132A3B)),
  backgroundLight("Light Background", Color(0xFFF2F3F7)),

  indicatorRainSensor("Rain Sensor", Color(0xFF910000)),
  indicatorTemperature("Temperature", Color(0xFF007E9E)),
  indicatorHumidity("Humidity", Color(0xFF82D4F1)),
  indicatorDistance("Distance", Color(0xFFF182D5)),

  statusSuccess("Success", Color(0xFF34C759)),
  statusWarning("Warning", Color(0xFFFF8D28)),
  statusFailed("Failed", Color(0xFFFF383C)),

  floodStatusGood("Good", Color(0xFFA0BA3B)),
  floodStatusWarning("Warning", Color(0xFFE5A80E)),
  floodStatusDanger("Danger", Color(0xFFA52525)),

  borderGood("Border Good", Color(0xFF80952F)),
  borderWarning("Border Warning", Color(0xFFB7860B)),
  borderDanger("Border Danger", Color(0xFF841E1E)),

  disable("Disabled/Inactive", Color(0xFFC1C1C1)),
  disableButton("Disabled Button", Color(0xFF042C45)),

  textUnselected("Unselected Text", Colors.white),
  textWhite("White Text", Colors.white),
  black("black", Colors.black);

  const FloodDetectionColors(this.name, this.color);

  final String name;
  final Color color;
}
