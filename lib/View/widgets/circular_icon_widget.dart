import 'package:flutter/material.dart';

class CircularIconWidget extends StatelessWidget {
  final IconData icon;
  final Color color;

  const CircularIconWidget({required this.icon, required this.color, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Icon(icon, color: Colors.white),
      );
}
