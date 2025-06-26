import 'package:flutter/material.dart';

class StandardContainer extends StatelessWidget {
  final Widget child;

  const StandardContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color.fromARGB(255, 97, 179, 247),
      ),
      child: child,
    );
  }
}
