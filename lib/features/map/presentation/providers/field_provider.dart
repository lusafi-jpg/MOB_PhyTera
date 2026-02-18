import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:riverpod/riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../../data/repositories/field_repository.dart';
import '../../domain/models/field_model.dart';
import '../../utils/area_calculator.dart';

final fieldRepositoryProvider = Provider<FieldRepository>((ref) {
  return InMemoryFieldRepository();
});

final savedFieldsProvider = FutureProvider<List<FieldModel>>((ref) async {
  final repository = ref.watch(fieldRepositoryProvider);
  return repository.getFields();
});

class FieldMapState {
  final List<LatLng> currentPoints;
  final double currentArea;
  final bool isDrawing;

  FieldMapState({
    this.currentPoints = const [],
    this.currentArea = 0.0,
    this.isDrawing = false,
  });

  FieldMapState copyWith({
    List<LatLng>? currentPoints,
    double? currentArea,
    bool? isDrawing,
  }) {
    return FieldMapState(
      currentPoints: currentPoints ?? this.currentPoints,
      currentArea: currentArea ?? this.currentArea,
      isDrawing: isDrawing ?? this.isDrawing,
    );
  }
}

class FieldMapNotifier extends StateNotifier<FieldMapState> {
  final FieldRepository _repository;
  final Ref _ref;

  FieldMapNotifier(this._repository, this._ref) : super(FieldMapState());

  void addPoint(LatLng point) {
    final newPoints = [...state.currentPoints, point];
    final area = AreaCalculator.calculateArea(newPoints);
    state = state.copyWith(
      currentPoints: newPoints,
      currentArea: area,
      isDrawing: true,
    );
  }

  void undoLastPoint() {
    if (state.currentPoints.isNotEmpty) {
      final newPoints = List<LatLng>.from(state.currentPoints)..removeLast();
      final area = AreaCalculator.calculateArea(newPoints);
      state = state.copyWith(
        currentPoints: newPoints,
        currentArea: area,
        isDrawing: newPoints.isNotEmpty,
      );
    }
  }

  void clearCurrentField() {
    state = state.copyWith(
      currentPoints: [],
      currentArea: 0.0,
      isDrawing: false,
    );
  }

  Future<void> saveCurrentField(String name) async {
    if (state.currentPoints.isEmpty) return;

    final field = FieldModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      points: state.currentPoints,
      areaInfo: state.currentArea,
      createdAt: DateTime.now(),
    );

    await _repository.saveField(field);
    // ignore: unused_result
    _ref.refresh(savedFieldsProvider); // Refresh the list of saved fields
    clearCurrentField();
  }
}

final fieldMapProvider = StateNotifierProvider<FieldMapNotifier, FieldMapState>(
  (ref) {
    final repository = ref.watch(fieldRepositoryProvider);
    return FieldMapNotifier(repository, ref);
  },
);
