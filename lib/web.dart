import 'package:flutter/widgets.dart';
import 'dart:html' as html;

class Interceptor extends StatelessWidget {
  final Widget child;

  const Interceptor({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    html.document.onContextMenu.listen((event) => event.preventDefault());
    return child;
  }
}
