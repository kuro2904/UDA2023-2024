import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PickNumberDialog extends StatefulWidget{
  TextEditingController controller;
  int quantity;
  VoidCallback  function;
  PickNumberDialog({super.key, required this.controller, required this.quantity, required this.function});
  @override
  State<StatefulWidget> createState() => PickNumberDialogState();

}

class PickNumberDialogState extends State<PickNumberDialog>{
  final _onlyNumbersFormatter = FilteringTextInputFormatter.digitsOnly;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Quantity'),
      content: TextFormField(
        controller: widget.controller,
        inputFormatters: [_onlyNumbersFormatter],
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'Quantity',
        ),
        onChanged: (value) {
          setState(() {
            widget.quantity = int.tryParse(value) ?? 1;
          });
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