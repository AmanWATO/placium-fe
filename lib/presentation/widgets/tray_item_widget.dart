import 'package:flutter/material.dart';

import '../../domain/models/element_type.dart';
import 'draggable_element_widget.dart';

class TrayItemWidget extends StatelessWidget {
  const TrayItemWidget({
    super.key,
    required this.type,
  });

  final ElementType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            color: Color(0x18000000),
            offset: Offset(0, 2),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: ElementVisual(type: type),
    );
  }
}
