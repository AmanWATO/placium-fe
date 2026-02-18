import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/controllers/canvas_controller.dart';
import '../../domain/models/position_model.dart';
import '../widgets/canvas_area.dart';
import '../widgets/drag_data.dart';
import '../widgets/element_tray.dart';

class CanvasScreen extends StatelessWidget {
  const CanvasScreen({super.key});

  static const String routeName = '/canvas';

  @override
  Widget build(BuildContext context) {
    return Consumer<CanvasController>(
      builder: (context, controller, _) {
        return Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
            title: const Text('Canvas'),
            actions: [
              TextButton.icon(
                onPressed: () {
                  controller.saveActiveCanvas();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Canvas saved for this session.')),
                  );
                },
                icon: const Icon(Icons.save_alt_rounded),
                label: const Text('Save'),
              ),
              const SizedBox(width: 8),
              TextButton.icon(
                onPressed: controller.clearCanvas,
                icon: const Icon(Icons.layers_clear_rounded),
                label: const Text('Clear'),
              ),
              const SizedBox(width: 12),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: CanvasArea(
                    elements: controller.elements,
                    onAddElement: (TrayDragData data, PositionModel position) {
                      controller.addElement(type: data.type, position: position);
                    },
                    onMoveElement: (ExistingElementDragData data, PositionModel position) {
                      controller.updateElementPosition(data.elementId, position);
                    },
                    onRemoveElement: controller.removeElement,
                    onElementInteraction: controller.bringElementToFront,
                  ),
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Element Tray'),
                ),
                const SizedBox(height: 8),
                const ElementTray(),
              ],
            ),
          ),
        );
      },
    );
  }
}
