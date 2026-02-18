import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/controllers/canvas_controller.dart';
import '../widgets/element_tray.dart';
import 'canvas_screen.dart';
import 'saved_canvases_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Placium')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Card(
            margin: const EdgeInsets.all(24),
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Spatial canvas workspace',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Create, arrange, and save canvases for this session.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () {
                      context.read<CanvasController>().startNewCanvas();
                      Navigator.pushNamed(context, CanvasScreen.routeName);
                    },
                    child: const Text('New Canvas'),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SavedCanvasesScreen.routeName);
                    },
                    child: const Text('Saved Canvases'),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),
                  const Text('Element catalog preview'),
                  const SizedBox(height: 8),
                  const ElementTray(isPreview: true),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
