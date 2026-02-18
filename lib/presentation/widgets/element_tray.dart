import 'package:flutter/material.dart';

import '../../domain/models/element_type.dart';
import 'drag_data.dart';
import 'tray_item_widget.dart';

class ElementTray extends StatelessWidget {
  const ElementTray({super.key, this.isPreview = false});

  final bool isPreview;

  static const List<ElementType> _elementTypes = [
    ElementType.circle,
    ElementType.square,
    ElementType.triangle,
    ElementType.star,
    ElementType.person,
    ElementType.tree,
    ElementType.house,
    ElementType.abstractBlock,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _elementTypes.length,
        itemBuilder: (context, index) {
          final type = _elementTypes[index];
          final tile = TrayItemWidget(type: type);
          if (isPreview) return tile;

          return LongPressDraggable<TrayDragData>(
            data: TrayDragData(type: type),
            feedback: Material(
              color: Colors.transparent,
              child: Opacity(opacity: 0.9, child: tile),
            ),
            childWhenDragging: Opacity(opacity: 0.35, child: tile),
            child: tile,
          );
        },
      ),
    );
  }
}
