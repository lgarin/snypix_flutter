import 'package:flutter/material.dart';
import 'package:snypix_flutter/core/values/consts.dart';

class WideRoundedButton extends StatelessWidget {
  static const radius = 20.0;
  static const _backgroundShape =
      RoundedRectangleBorder(borderRadius: RoundedBorder.wide);

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
        style: ElevatedButton.styleFrom(
            shape: _backgroundShape, backgroundColor: color),
        child: Text(text, style: Theme.of(context).textTheme.labelLarge),
      ),
    );
  }
}
