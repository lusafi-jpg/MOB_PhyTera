import 'package:latlong2/latlong.dart';

class FieldModel {
  final String id;
  final String name;
  final List<LatLng> points;
  final double areaInfo; // In square meters
  final DateTime createdAt;

  FieldModel({
    required this.id,
    required this.name,
    required this.points,
    required this.areaInfo,
    required this.createdAt,
  });

  double get areaInHectares => areaInfo / 10000;

  FieldModel copyWith({
    String? id,
    String? name,
    List<LatLng>? points,
    double? areaInfo,
    DateTime? createdAt,
  }) {
    return FieldModel(
      id: id ?? this.id,
      name: name ?? this.name,
      points: points ?? this.points,
      areaInfo: areaInfo ?? this.areaInfo,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
