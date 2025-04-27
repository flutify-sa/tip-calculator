import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BillInput extends StatelessWidget {
  final TextEditingController controller;

  const BillInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      decoration: const InputDecoration(
        labelText: 'Bill Amount',
        prefixText: 'R ',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter bill amount';
        }
        if (double.tryParse(value) == null) {
          return 'Invalid number';
        }
        if (double.parse(value) <= 0) {
          return 'Bill amount must be greater than zero';
        }
        return null;
      },
    );
  }
}
