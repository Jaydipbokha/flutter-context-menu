import 'package:flutter/widgets.dart';

class Interceptor extends StatelessWidget {
  final Widget child;

  const Interceptor({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
