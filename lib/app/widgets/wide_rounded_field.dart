import 'package:flutter/material.dart';

class WideRoundedField extends StatelessWidget {
  static const radius = 10.0;

  final Widget child;
  final EdgeInsetsGeometry? padding;

  const WideRoundedField({super.key, this.padding, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(radius))),
      padding: padding ?? const EdgeInsets.all(radius),
      child: child,
    );
  }
}
