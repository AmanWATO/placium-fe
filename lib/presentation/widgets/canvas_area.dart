import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import '../../domain/models/canvas_element.dart';
import '../../domain/models/position_model.dart';
import 'drag_data.dart';
import 'draggable_element_widget.dart';

class CanvasArea extends StatefulWidget {
  const CanvasArea({
    super.key,
    required this.elements,
    required this.onAddElement,
    required this.onMoveElement,
    required this.onRemoveElement,
    required this.onElementInteraction,
  });

  final List<CanvasElement> elements;
  final void Function(TrayDragData data, PositionModel position) onAddElement;
  final void Function(ExistingElementDragData data, PositionModel position) onMoveElement;
  final void Function(String elementId) onRemoveElement;
  final void Function(String elementId) onElementInteraction;

  @override
  State<CanvasArea> createState() => _CanvasAreaState();
}

class _CanvasAreaState extends State<CanvasArea> {
  final GlobalKey _canvasKey = GlobalKey();

  PositionModel _toCanvasPosition(Offset globalPosition) {
    final box = _canvasKey.currentContext!.findRenderObject() as RenderBox;
    final local = box.globalToLocal(globalPosition);
    return PositionModel(
      x: local.dx - (AppConstants.defaultElementSize / 2),
      y: local.dy - (AppConstants.defaultElementSize / 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      child: Container(
        key: _canvasKey,
        constraints: const BoxConstraints(minHeight: AppConstants.canvasMinHeight),
        decoration: BoxDecoration(
          color: const Color(0xFFFCFDFE),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0x11000000)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: DragTarget<Object>(
            onWillAcceptWithDetails: (_) => true,
            onAcceptWithDetails: (details) {
              final localPosition = _toCanvasPosition(details.offset);
              final data = details.data;

              if (data is TrayDragData) {
                widget.onAddElement(data, localPosition);
              } else if (data is ExistingElementDragData) {
                widget.onMoveElement(data, localPosition);
              }
            },
            builder: (context, _, __) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  if (widget.elements.isEmpty)
                    const Center(
                      child: Text(
                        'Long-press any item from the tray and drop it here.',
                        style: TextStyle(color: Color(0xFF7E8792)),
                      ),
                    ),
                  ...widget.elements.map(
                    (element) => Positioned(
                      left: element.position.x,
                      top: element.position.y,
                      child: DraggableElementWidget(
                        key: ValueKey(element.id),
                        element: element,
                        onRemoved: () => widget.onRemoveElement(element.id),
                        onDragStarted: () => widget.onElementInteraction(element.id),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
