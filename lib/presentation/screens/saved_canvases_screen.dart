import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/controllers/canvas_controller.dart';
import 'canvas_screen.dart';

class SavedCanvasesScreen extends StatelessWidget {
  const SavedCanvasesScreen({super.key});

  static const String routeName = '/saved';

  @override
  Widget build(BuildContext context) {
    return Consumer<CanvasController>(
      builder: (context, controller, _) {
        final saved = controller.savedCanvases;

        return Scaffold(
          appBar: AppBar(title: const Text('Saved Canvases')),
          body: saved.isEmpty
              ? const Center(child: Text('No saved canvases yet.'))
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: saved.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final canvas = saved[index];
                    return Card(
                      child: ListTile(
                        title: Text(canvas.name),
                        subtitle: Text(
                          'Elements: ${canvas.elements.length} • Updated: ${canvas.updatedAt}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: FilledButton.tonal(
                          onPressed: () {
                            controller.loadCanvas(canvas.id);
                            Navigator.pushNamed(context, CanvasScreen.routeName);
                          },
                          child: const Text('Open'),
                        ),
                        onTap: () {
                          final json = const JsonEncoder.withIndent('  ').convert(canvas.toJson());
                          showDialog<void>(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(canvas.name),
                                content: SingleChildScrollView(child: Text(json)),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Close'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
