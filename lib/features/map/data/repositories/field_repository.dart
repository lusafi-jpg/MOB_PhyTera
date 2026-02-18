import '../../domain/models/field_model.dart';

abstract class FieldRepository {
  Future<List<FieldModel>> getFields();
  Future<void> saveField(FieldModel field);
  Future<void> deleteField(String id);
}

class InMemoryFieldRepository implements FieldRepository {
  final List<FieldModel> _fields = [];

  @override
  Future<List<FieldModel>> getFields() async {
    return List.unmodifiable(_fields);
  }

  @override
  Future<void> saveField(FieldModel field) async {
    final index = _fields.indexWhere((f) => f.id == field.id);
    if (index >= 0) {
      _fields[index] = field;
    } else {
      _fields.add(field);
    }
  }

  @override
  Future<void> deleteField(String id) async {
    _fields.removeWhere((f) => f.id == id);
  }
}
