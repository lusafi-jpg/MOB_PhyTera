import 'dart:math';
import 'package:latlong2/latlong.dart';

class AreaCalculator {
  static const double earthRadius = 6371000; // Meters

  /// Calculates the area of a polygon defined by a list of LatLng points.
  /// Returns the area in square meters.
  static double calculateArea(List<LatLng> points) {
    if (points.length < 3) return 0.0;

    double area = 0.0;
    
    // Using Shoelace formula adaptation for spherical coordinates (approximated)
    // For small areas like fields, this is sufficient.
    // A robust way is projecting to 2D plane locally or using spherical excess.
    // For simplicity and standard field sizes, we can use a simpler projection.
    
    // We'll use the spherical excess formula for better accuracy on globe
    // or a simple projection if points are close.
    // Let's use a standard implementation for spherical polygon area.
    
    // Implementation based on spherical geometry
    if (points.length > 2) {
      for (var i = 0; i < points.length; i++) {
        var p1 = points[i];
        var p2 = points[(i + 1) % points.length];
        
        area += toRadians(p2.longitude - p1.longitude) *
            (2 + sin(toRadians(p1.latitude)) + sin(toRadians(p2.latitude)));
      }
      area = area * earthRadius * earthRadius / 2.0;
    }
    
    return area.abs();
  }

  static double toRadians(double degree) {
    return degree * pi / 180;
  }
}
