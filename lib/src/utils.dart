import 'package:flutter/material.dart';

/// Extension to darken a color by a given amount (0 to 1).
extension ColorExtensions on Color {
  Color darken([double amount = 0.1]) {
    // Ensure amount is within valid range
    assert(amount >= 0 && amount <= 1, 'Amount should be between 0 and 1');

    // Convert color to HSV, which makes it easier to adjust brightness
    final hsvColor = HSVColor.fromColor(this);

    // Calculate new value (brightness) of the color
    final newValue = (hsvColor.value - amount).clamp(0.0, 1.0);

    // Return new color with adjusted brightness
    return hsvColor.withValue(newValue).toColor();
  }
}

enum MPageType { outlined, filled }
