import 'package:flutter/material.dart';

class Barriers extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final size;

  const Barriers({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(
          width: 10,
          color: Colors.green.shade300,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
