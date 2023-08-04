import 'package:flutter/material.dart';

Widget buildSensorCard({String? title, String? value, IconData? icon}) {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Icon(
            icon,
            size: 64,
            color: Colors.blue,
          ),
          const SizedBox(height: 16),
          Text(
            title!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value!,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    ),
  );
}
