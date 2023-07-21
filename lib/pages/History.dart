import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracking_history/Classes/Historyclass.dart';

class HistoryPage extends StatelessWidget {
  final List<SensorData> historyList;

  HistoryPage({required this.historyList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: Text('History'),
      ),
      body: ListView.builder(
        itemCount: historyList.length,
        itemBuilder: (context, index) {
          final data = historyList[index];
          final formattedDateTime = DateFormat('EEE, MMM d, HH:mm')
              .format(DateTime.parse(data.timestamp));
          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(Icons.access_time),
              title: Text('$formattedDateTime'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Temperature: ${data.temperature}°C'),
                  Text('Humidity: ${data.soilMoisture}%'),
                  Text('Salinity: ${data.soilSalinity}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
