import 'package:flutter/cupertino.dart';

class WrapListMenu extends StatelessWidget {
  const WrapListMenu({
    super.key,
    required this.children,
    this.margin,
    this.scrollDirection,
    this.height,
  });

  final List<Widget> children;
  final EdgeInsetsGeometry? margin;
  final Axis? scrollDirection;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 200,
      child: ListView(
        padding: const EdgeInsets.all(8.0),
        scrollDirection: scrollDirection ?? Axis.vertical,
        children: [
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: children
                .map((e) => Container(
                    margin: margin ?? const EdgeInsets.all(8), child: e))
                .toList(),
          ),
        ],
      ),
    );
  }
}
