import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import '../../domain/models/canvas_element.dart';
import '../../domain/models/element_type.dart';
import 'drag_data.dart';

class DraggableElementWidget extends StatelessWidget {
  const DraggableElementWidget({
    super.key,
    required this.element,
    required this.onRemoved,
    required this.onDragStarted,
  });

  final CanvasElement element;
  final VoidCallback onRemoved;
  final VoidCallback onDragStarted;

  @override
  Widget build(BuildContext context) {
    final visual = SizedBox(
      width: AppConstants.defaultElementSize,
      height: AppConstants.defaultElementSize,
      child: Transform.rotate(
        angle: element.rotation,
        child: Transform.scale(
          scale: element.scale,
          child: ElementVisual(type: element.type),
        ),
      ),
    );

    return LongPressDraggable<ExistingElementDragData>(
      data: ExistingElementDragData(elementId: element.id),
      onDragStarted: onDragStarted,
      onDraggableCanceled: (_, __) => onRemoved(),
      feedback: Material(
        color: Colors.transparent,
        child: Opacity(opacity: 0.9, child: visual),
      ),
      childWhenDragging: const SizedBox.shrink(),
      child: GestureDetector(
        onTap: onDragStarted,
        child: visual,
      ),
    );
  }
}

class ElementVisual extends StatelessWidget {
  const ElementVisual({super.key, required this.type});

  final ElementType type;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ElementType.circle:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF7D8CA3),
          ),
        );
      case ElementType.square:
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF9AA7B1),
            borderRadius: BorderRadius.circular(10),
          ),
        );
      case ElementType.triangle:
        return CustomPaint(painter: _TrianglePainter(), size: Size.infinite);
      case ElementType.star:
        return const Icon(Icons.star_rounded, size: 56, color: Color(0xFF7D8CA3));
      case ElementType.person:
        return const Icon(Icons.person_rounded, size: 56, color: Color(0xFF6F7D8A));
      case ElementType.tree:
        return const Icon(Icons.park_rounded, size: 56, color: Color(0xFF6B8A74));
      case ElementType.house:
        return const Icon(Icons.home_rounded, size: 56, color: Color(0xFF8A8170));
      case ElementType.abstractBlock:
        return CustomPaint(painter: _AbstractBlockPainter(), size: Size.infinite);
    }
  }
}

class _TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, Paint()..color = const Color(0xFF7B8795));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _AbstractBlockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF7C8894);
    final rect1 = RRect.fromRectAndRadius(
      Rect.fromLTWH(4, size.height * 0.1, size.width * 0.8, size.height * 0.35),
      const Radius.circular(6),
    );
    final rect2 = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.2, size.height * 0.5, size.width * 0.75, size.height * 0.35),
      const Radius.circular(6),
    );
    canvas.drawRRect(rect1, paint);
    canvas.drawRRect(rect2, paint..color = const Color(0xFF94A0AB));

    final circlePaint = Paint()..color = const Color(0xFF65717D);
    canvas.drawCircle(Offset(size.width * 0.23, size.height * 0.6), 4 + math.max(1, size.width * 0.04), circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
