import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ResultsDisplay extends StatelessWidget {
  final double billAmount;
  final double tipAmount;
  final double totalAmount;

  final currencyFormat = NumberFormat.currency(locale: 'en_ZA', symbol: 'R');

  ResultsDisplay({
    super.key,
    required this.billAmount,
    required this.tipAmount,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bill Amount: ${currencyFormat.format(billAmount)}',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Tip Amount: ${currencyFormat.format(tipAmount)}',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Total Amount: ${currencyFormat.format(totalAmount)}',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
