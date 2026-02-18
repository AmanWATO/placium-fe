import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/controllers/canvas_controller.dart';
import '../../core/constants/app_constants.dart';
import '../screens/canvas_screen.dart';
import '../screens/home_screen.dart';
import '../screens/saved_canvases_screen.dart';

class PlaciumApp extends StatelessWidget {
  const PlaciumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CanvasController(),
      child: MaterialApp(
        title: AppConstants.appTitle,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          colorSchemeSeed: Colors.blueGrey,
          scaffoldBackgroundColor: const Color(0xFFF4F6F8),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            elevation: 0,
          ),
        ),
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (_) => const HomeScreen(),
          CanvasScreen.routeName: (_) => const CanvasScreen(),
          SavedCanvasesScreen.routeName: (_) => const SavedCanvasesScreen(),
        },
      ),
    );
  }
}
