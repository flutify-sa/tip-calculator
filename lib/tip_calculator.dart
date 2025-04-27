import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TipCalculator extends StatefulWidget {
  const TipCalculator({super.key});

  @override
  TipCalculatorState createState() => TipCalculatorState();
}

class TipCalculatorState extends State<TipCalculator> {
  final _billAmountController = TextEditingController();
  final _customTipController = TextEditingController();
  double _tipPercentage = 0.15; // Default tip percentage is 15%
  double _billAmount = 0.0;
  double _tipAmount = 0.0;
  double _totalAmount = 0.0;
  final _formKey = GlobalKey<FormState>();
  final currencyFormat = NumberFormat.currency(
    locale: 'en_ZA',
    symbol: 'R',
  ); // Use en_ZA for South African Rand

  // Function to calculate tip
  void _calculateTip() {
    if (_formKey.currentState!.validate()) {
      // Use form validation
      setState(() {
        _billAmount = double.parse(_billAmountController.text.trim());
        if (_customTipController.text.isNotEmpty) {
          // Parse custom tip percentage
          _tipPercentage = double.parse(_customTipController.text.trim()) / 100;
        }
        _tipAmount = _billAmount * _tipPercentage;
        _totalAmount = _billAmount + _tipAmount;
      });
    }
  }

  // Function to update tip percentage and calculate tip
  void _selectTipPercentage(double percentage) {
    setState(() {
      _tipPercentage = percentage;
      _calculateTip(); // Recalculate immediately
    });
  }

  // Function to clear all fields
  void _clearFields() {
    setState(() {
      _billAmountController.clear();
      _customTipController.clear();
      _tipPercentage = 0.15; // Reset to default
      _billAmount = 0.0;
      _tipAmount = 0.0;
      _totalAmount = 0.0;
    });
  }

  @override
  void dispose() {
    _billAmountController.dispose();
    _customTipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tip Calculator'), centerTitle: true),
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            "assets/tip.png", // Path to your image
            fit: BoxFit.cover, // Cover the entire screen
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[200], // Light grey background
                child: const Center(
                  child: Text(
                    'Failed to load image',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              );
            },
          ),
          // Content of the Calculator
          Container(
            color: Colors.white.withValues(
              alpha: 0.8,
            ), // Changed withOpacity to withValues
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Bill Amount Input
                  TextFormField(
                    controller: _billAmountController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}'),
                      ), // Allow only numbers and decimal
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Bill Amount',
                      prefixText: 'R ', // Display "R"
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
                  ),
                  const SizedBox(height: 20.0),

                  // Tip Percentage Buttons
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12.0,
                    runSpacing: 12.0,
                    children: [
                      for (double percentage in [0.05, 0.10, 0.15, 0.20, 0.25])
                        ElevatedButton(
                          onPressed: () => _selectTipPercentage(percentage),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                _tipPercentage == percentage
                                    ? Colors
                                        .green // Green background if selected
                                    : Colors
                                        .grey[300], // Default grey background
                            foregroundColor:
                                _tipPercentage == percentage
                                    ? Colors
                                        .white // White text if selected
                                    : Colors.black, // Black text otherwise
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
                  ),
                  const SizedBox(height: 20.0),

                  // Custom Tip Input
                  TextFormField(
                    controller: _customTipController,
                    keyboardType: const TextInputType.numberWithOptions(),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d{0,2}'),
                      ), // Allow only numbers for percentage
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Custom Tip (%)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        final tipValue = int.tryParse(value);
                        if (tipValue == null) {
                          return 'Invalid number';
                        }
                        if (tipValue <= 0) {
                          return 'Tip must be greater than zero';
                        }
                        if (tipValue > 100) {
                          return 'Tip must be less than 100';
                        }
                      }
                      return null;
                    },
                    onChanged: (_) {
                      _calculateTip();
                    },
                  ),
                  const SizedBox(height: 20.0),

                  // Calculate and Clear Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: _calculateTip,
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
                        child: const Text(
                          'Calculate Tip',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _clearFields,
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
                        child: const Text(
                          'Clear',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),

                  // Results Display
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bill Amount: ${currencyFormat.format(_billAmount)}',
                            style: const TextStyle(fontSize: 18.0),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'Tip Amount: ${currencyFormat.format(_tipAmount)}',
                            style: const TextStyle(fontSize: 18.0),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'Total Amount: ${currencyFormat.format(_totalAmount)}',
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
