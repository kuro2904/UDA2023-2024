import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PickNumberDialog extends StatefulWidget {
  final TextEditingController controller;
  final int initialQuantity;
  final Function(int) onQuantityChanged; // Callback to notify the parent widget about quantity changes
  final VoidCallback function;

  PickNumberDialog({
    Key? key,
    required this.controller,
    required this.initialQuantity,
    required this.onQuantityChanged,
    required this.function,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => PickNumberDialogState();
}

class PickNumberDialogState extends State<PickNumberDialog> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Quantity'),
      content: TextFormField(
        controller: widget.controller,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'Quantity',
        ),
        onChanged: (value) {
          final newQuantity = int.tryParse(value) ?? 1;
          setState(() {
            quantity = newQuantity;
          });
          widget.onQuantityChanged(newQuantity);
        },
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: widget.function,
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
