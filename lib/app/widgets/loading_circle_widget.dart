import 'package:flutter/material.dart';

class LoadingCircleWidget extends StatelessWidget {
  final double? progressValue;

  const LoadingCircleWidget({super.key, this.progressValue});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: const Alignment(0.0, 0.0),
        child: CircularProgressIndicator(value: progressValue),
      ),
    );
  }
}
