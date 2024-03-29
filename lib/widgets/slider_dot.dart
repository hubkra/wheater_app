import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class SliderDot extends StatelessWidget {
  bool isActive;
  SliderDot(this.isActive, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: isActive ? 12 : 5,
      height: 5,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white54,
        borderRadius: BorderRadius.circular(5),
      ),
      duration: Duration(microseconds: 150),
    );
  }
}
