import 'package:flutter/material.dart';

class TipPercentageButtons extends StatelessWidget {
  final Function(double) selectTipPercentage;

  const TipPercentageButtons({super.key, required this.selectTipPercentage});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12.0,
      runSpacing: 12.0,
      children: [
        for (double percentage in [0.05, 0.10, 0.15, 0.20, 0.25])
          ElevatedButton(
            onPressed: () => selectTipPercentage(percentage),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[300],
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 12.0,
              ),
              minimumSize: Size.zero,
            ),
            child: Text('${(percentage * 100).toInt()}%'),
          ),
      ],
    );
  }
}
