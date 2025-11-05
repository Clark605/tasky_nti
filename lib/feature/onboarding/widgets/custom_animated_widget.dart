import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class CustomAnimatedWidget extends StatelessWidget {
  final int index;
  final int delay;
  final Widget child;

  const CustomAnimatedWidget({
    super.key,
    required this.index,
    required this.delay,
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    return (index == 2)
        ? FadeInUp(
            delay: Duration(milliseconds: delay),
            child: child,
          )
        : FadeInDown(
            delay: Duration(milliseconds: delay),
            child: child,
          );
  }
}
