import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/components/clock/view_models/clock_view_model.dart';

class ClockWidget extends StatelessWidget {
  const ClockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ClockViewModel>(
      builder: (context, clockModel, child) {
        return Text(
          clockModel.formattedTime,
          style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.bold
          ),
        );
      },
    );
  }
}
