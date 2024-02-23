import 'package:flutter/material.dart';

class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    this.initialOpen, // Danh sách sổ ra sẵn hay không
    this.icon, // Icon khi danh sách đóng
    required this.distance, // Khoảng cách giữa các item
    required this.children, // Danh sách item
  });

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;
  final Icon? icon;

  @override
  State<ExpandableFab> createState() => ExpandableFabState();
}

class ExpandableFabState extends State<ExpandableFab> {
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
  }

  void _toggle() {
    setState(() {
      _open = !_open;
    });
  }

  Widget _buildTapToClose() {
    return Column(
      children: childrenWithSpacing(
        children: [
          Column(
            children: childrenWithSpacing(
              children: widget.children,
              height: widget.distance,
            ),
          ),
          Material(
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            elevation: 4,
            child: InkWell(
              onTap: _toggle,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.close,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ],
        height: widget.distance,
      ),
    );
  }

  Widget _buildTapToOpen() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
            _open ? 0.7 : 1.0,
            _open ? 0.7 : 1.0,
            1.0
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.25, 1.0, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: _toggle,
            child: widget.icon ?? const Icon(Icons.create),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _open ? _buildTapToClose() : _buildTapToOpen(),
      ],
    );
  }

  List<Widget> childrenWithSpacing({
    required List<Widget> children,
    double width = 8,
    double height = 8,
  }) {
    final space = Container(width: width, height: height,);
    return children.expand((element) => [element, space]).toList();
  }
}