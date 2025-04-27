import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/tip.png",
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey[200],
          child: const Center(
            child: Text(
              'Failed to load image',
              style: TextStyle(color: Colors.red),
            ),
          ),
        );
      },
    );
  }
}
