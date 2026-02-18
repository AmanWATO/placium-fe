import 'package:flutter/foundation.dart';

import '../../domain/models/canvas_element.dart';
import '../../domain/models/canvas_model.dart';
import '../../domain/models/element_type.dart';
import '../../domain/models/position_model.dart';

class CanvasController extends ChangeNotifier {
  CanvasController() : _activeCanvas = _createEmptyCanvas();

  static int _idCounter = 0;

  CanvasModel _activeCanvas;
  final List<CanvasModel> _savedCanvases = [];

  CanvasModel get activeCanvas => _activeCanvas;
  List<CanvasElement> get elements {
    final next = [..._activeCanvas.elements]
      ..sort((a, b) => a.layer.compareTo(b.layer));
    return List.unmodifiable(next);
  }

  List<CanvasModel> get savedCanvases => List.unmodifiable(_savedCanvases);

  void addElement({
    required ElementType type,
    required PositionModel position,
    double rotation = 0,
    double scale = 1,
  }) {
    final nextElement = CanvasElement(
      id: _nextId('element'),
      type: type,
      position: position,
      rotation: rotation,
      scale: scale,
      layer: _activeCanvas.elements.length,
    );

    _activeCanvas = _activeCanvas.addElement(nextElement);
    notifyListeners();
  }

  void updateElementPosition(String elementId, PositionModel position) {
    final element = _activeCanvas.elements.where((item) => item.id == elementId).firstOrNull;
    if (element == null) return;

    _activeCanvas = _activeCanvas.updateElement(element.copyWith(position: position));
    notifyListeners();
  }

  void removeElement(String elementId) {
    _activeCanvas = _activeCanvas.removeElement(elementId);
    notifyListeners();
  }

  void reorderLayer(String elementId, int targetLayer) {
    _activeCanvas = _activeCanvas.reorderLayer(elementId, targetLayer);
    notifyListeners();
  }

  void bringElementToFront(String elementId) {
    reorderLayer(elementId, _activeCanvas.elements.length - 1);
  }

  void clearCanvas() {
    _activeCanvas = _activeCanvas.clear();
    notifyListeners();
  }

  void saveActiveCanvas() {
    final timestamp = DateTime.now();
    final snapshot = _activeCanvas.copyWith(
      id: _nextId('canvas'),
      name: 'Canvas ${_savedCanvases.length + 1}',
      createdAt: timestamp,
      updatedAt: timestamp,
    );

    _savedCanvases.insert(0, snapshot);
    notifyListeners();
  }

  void loadCanvas(String canvasId) {
    final match = _savedCanvases.where((canvas) => canvas.id == canvasId).firstOrNull;
    if (match == null) return;
    _activeCanvas = match.copyWith(updatedAt: DateTime.now());
    notifyListeners();
  }

  void startNewCanvas() {
    _activeCanvas = _createEmptyCanvas();
    notifyListeners();
  }

  Map<String, dynamic> serializeActiveCanvas() => _activeCanvas.toJson();

  static CanvasModel _createEmptyCanvas() {
    final now = DateTime.now();
    return CanvasModel(
      id: _nextId('active'),
      name: 'Working Canvas',
      createdAt: now,
      updatedAt: now,
      elements: const [],
    );
  }

  static String _nextId(String prefix) {
    _idCounter += 1;
    return '$prefix-$_idCounter';
  }
}
