import 'package:flutter/material.dart';
import 'context_menu.dart'; // For web-only use in Interceptor

void main() {
  runApp(const MyApp());
}

/// Root of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: HomePage());
  }
}

/// Home page showing four RectangleAreas with ContextMenu.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double boxSize = constraints.biggest.shortestSide / 4;
        final double paddingW = constraints.maxWidth / 6;
        final double paddingH = constraints.maxHeight / 6;

        return Scaffold(
          body: Stack(
            children: [
              Positioned(
                left: paddingW,
                top: paddingH,
                child: ContextMenu(
                  child: RectangleArea(
                    label: 'Top left',
                    color: Colors.yellow,
                    size: boxSize,
                  ),
                ),
              ),
              Positioned(
                right: paddingW,
                top: paddingH,
                child: ContextMenu(
                  child: RectangleArea(
                    label: 'Top right',
                    color: Colors.green,
                    size: boxSize,
                  ),
                ),
              ),
              Positioned(
                right: paddingW,
                bottom: paddingH,
                child: ContextMenu(
                  child: RectangleArea(
                    label: 'Bottom right',
                    color: Colors.blue,
                    size: boxSize,
                  ),
                ),
              ),
              Positioned(
                left: paddingW,
                bottom: paddingH,
                child: ContextMenu(
                  child: RectangleArea(
                    label: 'Bottom left',
                    color: Colors.purple,
                    size: boxSize,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// A colored square with a centered label.
class RectangleArea extends StatelessWidget {
  const RectangleArea({
    super.key,
    required this.label,
    required this.size,
    required this.color,
  });

  final String label;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color),
      child: Center(child: Text(label)),
    );
  }
}
