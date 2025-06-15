import 'package:flutter/material.dart';
import 'interceptor.dart';

class ContextMenu extends StatefulWidget {
  final Widget child;

  const ContextMenu({super.key, required this.child});

  @override
  State<ContextMenu> createState() => _ContextMenuState();
}

class _ContextMenuState extends State<ContextMenu> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  void _showMenu(BuildContext context, Offset position) {
    _hideMenu();

    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final Size screenSize = overlay.size;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        double left = position.dx;
        double top = position.dy;
        const double menuWidth = 150;
        const double menuHeight = 150;

        // Ensure menu stays within bounds
        if (left + menuWidth > screenSize.width) {
          left = screenSize.width - menuWidth;
        }
        if (top + menuHeight > screenSize.height) {
          top = screenSize.height - menuHeight;
        }

        return Positioned(
          left: left,
          top: top,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            child: Material(
              elevation: 8,
              child: SizedBox(
                width: menuWidth,
                height: menuHeight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildMenuItem("Create"),
                    _buildMenuItem("Edit"),
                    _buildMenuItem("Remove"),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  Widget _buildMenuItem(String label) {
    return ListTile(
      title: Text(label),
      onTap: _hideMenu, // No action for now
    );
  }

  void _hideMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Interceptor(
      child: CompositedTransformTarget(
        link: _layerLink,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onSecondaryTapDown: (details) => _showMenu(context, details.globalPosition),
          onTap: _hideMenu,
          child: widget.child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _hideMenu();
    super.dispose();
  }
}
