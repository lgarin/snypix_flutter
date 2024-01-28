import 'package:flutter/material.dart';

class WideRoundedButton extends StatelessWidget {
  static const radius = 20.0;
  static const _shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(radius)));

  final String text;
  final VoidCallback onPressed;
  final Color color;

  const WideRoundedButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 2 * radius,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(shape: _shape, backgroundColor: color),
        child: Text(text, style: Theme.of(context).textTheme.labelLarge),
      ),
    );
  }
}
