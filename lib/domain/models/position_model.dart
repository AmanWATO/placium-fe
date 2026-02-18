/// Pure Dart position model to avoid Flutter SDK dependencies in domain.
class PositionModel {
  final double x;
  final double y;

  const PositionModel({required this.x, required this.y});

  PositionModel copyWith({double? x, double? y}) {
    return PositionModel(
      x: x ?? this.x,
      y: y ?? this.y,
    );
  }

  Map<String, dynamic> toJson() => {'x': x, 'y': y};

  factory PositionModel.fromJson(Map<String, dynamic> json) {
    return PositionModel(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
    );
  }
}
