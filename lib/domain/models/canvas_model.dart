import 'canvas_element.dart';

class CanvasModel {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<CanvasElement> elements;

  const CanvasModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.elements,
  });

  CanvasModel copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<CanvasElement>? elements,
  }) {
    return CanvasModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      elements: elements ?? this.elements,
    );
  }

  CanvasModel addElement(CanvasElement element) {
    final normalized = normalizeLayers([
      ...elements,
      element.copyWith(layer: elements.length),
    ]);

    return copyWith(elements: normalized, updatedAt: DateTime.now());
  }

  CanvasModel updateElement(CanvasElement updatedElement) {
    final next = elements
        .map((element) => element.id == updatedElement.id ? updatedElement : element)
        .toList();
    return copyWith(elements: normalizeLayers(next), updatedAt: DateTime.now());
  }

  CanvasModel removeElement(String elementId) {
    final next = elements.where((element) => element.id != elementId).toList();
    return copyWith(elements: normalizeLayers(next), updatedAt: DateTime.now());
  }

  CanvasModel reorderLayer(String elementId, int targetLayer) {
    if (elements.isEmpty) return this;

    final sorted = [...elements]..sort((a, b) => a.layer.compareTo(b.layer));
    final index = sorted.indexWhere((element) => element.id == elementId);
    if (index == -1) return this;

    final moved = sorted.removeAt(index);
    final clampedTarget = targetLayer.clamp(0, sorted.length);
    sorted.insert(clampedTarget, moved);

    return copyWith(elements: normalizeLayers(sorted), updatedAt: DateTime.now());
  }

  CanvasModel clear() {
    return copyWith(elements: const [], updatedAt: DateTime.now());
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'elements': elements.map((element) => element.toJson()).toList(),
    };
  }

  factory CanvasModel.fromJson(Map<String, dynamic> json) {
    return CanvasModel(
      id: json['id'] as String,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      elements: (json['elements'] as List<dynamic>)
          .map((elementJson) =>
              CanvasElement.fromJson(elementJson as Map<String, dynamic>))
          .toList(),
    );
  }

  static List<CanvasElement> normalizeLayers(List<CanvasElement> raw) {
    final ordered = [...raw]..sort((a, b) => a.layer.compareTo(b.layer));
    return [
      for (var i = 0; i < ordered.length; i++) ordered[i].copyWith(layer: i),
    ];
  }
}
