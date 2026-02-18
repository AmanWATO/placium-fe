import '../../domain/models/element_type.dart';

class TrayDragData {
  final ElementType type;

  const TrayDragData({required this.type});
}

class ExistingElementDragData {
  final String elementId;

  const ExistingElementDragData({required this.elementId});
}
