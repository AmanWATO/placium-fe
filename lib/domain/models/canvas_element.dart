import 'element_type.dart';
import 'position_model.dart';

class CanvasElement {
  final String id;
  final ElementType type;
  final PositionModel position;
  final double rotation;
  final double scale;
  final int layer;

  const CanvasElement({
    required this.id,
    required this.type,
    required this.position,
    required this.rotation,
    required this.scale,
    required this.layer,
  });

  CanvasElement copyWith({
    String? id,
    ElementType? type,
    PositionModel? position,
    double? rotation,
    double? scale,
    int? layer,
  }) {
    return CanvasElement(
      id: id ?? this.id,
      type: type ?? this.type,
      position: position ?? this.position,
      rotation: rotation ?? this.rotation,
      scale: scale ?? this.scale,
      layer: layer ?? this.layer,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.key,
      'position': position.toJson(),
      'rotation': rotation,
      'scale': scale,
      'layer': layer,
    };
  }

  factory CanvasElement.fromJson(Map<String, dynamic> json) {
    return CanvasElement(
      id: json['id'] as String,
      type: ElementTypeX.fromKey(json['type'] as String),
      position: PositionModel.fromJson(json['position'] as Map<String, dynamic>),
      rotation: (json['rotation'] as num).toDouble(),
      scale: (json['scale'] as num).toDouble(),
      layer: (json['layer'] as num).toInt(),
    );
  }
}
