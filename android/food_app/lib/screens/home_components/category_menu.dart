import 'package:flutter/cupertino.dart';

class CategoryMenu extends StatelessWidget {
  const CategoryMenu({
    super.key,
    required this.children,
    this.margin,
  });

  final List<Widget> children;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      children: children.map((e) => Container(margin: margin ?? const EdgeInsets.all(8),child: e,)).toList(),
    );
  }
}