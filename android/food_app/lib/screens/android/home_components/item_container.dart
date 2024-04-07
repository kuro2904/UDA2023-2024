import 'package:flutter/material.dart';

class ItemContainer extends StatelessWidget {
  final double width, height;
  final Color backgroundColor, textColor;
  final Decoration? decoration;
  final VoidCallback? onTap;
  final List<Widget> children;

  const ItemContainer({
    super.key,
    this.width = 150,
    this.height = 150,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.decoration,
    this.onTap,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: decoration ??
            BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
