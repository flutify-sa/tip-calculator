import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTipInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback calculateTip;

  const CustomTipInput({
    super.key,
    required this.controller,
    required this.calculateTip,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'^\d{0,2}')),
      ],
      decoration: const InputDecoration(
        labelText: 'Custom Tip (%)',
        border: OutlineInputBorder(),
      ),
      onChanged: (_) {
        calculateTip();
      },
    );
  }
}
