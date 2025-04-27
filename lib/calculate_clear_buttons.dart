import 'package:flutter/material.dart';

class CalculateClearButtons extends StatelessWidget {
  final VoidCallback calculateTip;
  final VoidCallback clearFields;

  const CalculateClearButtons({
    super.key,
    required this.calculateTip,
    required this.clearFields,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: calculateTip,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 12.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          child: const Text('Calculate Tip', style: TextStyle(fontSize: 18.0)),
        ),
        ElevatedButton(
          onPressed: clearFields,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 12.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          child: const Text('Clear', style: TextStyle(fontSize: 18.0)),
        ),
      ],
    );
  }
}
