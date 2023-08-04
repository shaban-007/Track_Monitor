import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracking_history/models/Historyclass.dart';
import 'dart:math';

class HistoryPage extends StatelessWidget {
  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  final List<SensorData> historyList;

  HistoryPage({required this.historyList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: const Text('History'),
      ),
      body: ListView.builder(
        itemCount: historyList.length,
        itemBuilder: (context, index) {
          final data = historyList[index];
          final formattedDateTime = DateFormat('EEE, MMM d, HH:mm')
              .format(DateTime.parse(data.timestamp));
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.access_time),
              title: Text('$formattedDateTime'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Temperature: ${roundDouble(double.parse(data.temperature), 2)}°C'),
                  Text(
                      'Humidity: ${roundDouble(double.parse(data.soilMoisture), 2)}%'),
                  Text(
                      'Salinity: ${roundDouble(double.parse(data.soilSalinity), 2)}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
