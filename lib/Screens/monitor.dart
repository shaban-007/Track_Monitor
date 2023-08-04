import 'package:flutter/material.dart';
import 'package:tracking_history/Screens/charts.dart';
import 'package:tracking_history/widgets/sensorCard.dart';
import 'package:tracking_history/services/ServiceClass.dart';
import '../models/Historyclass.dart';
import 'History.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:math';

class Monitor extends StatelessWidget {
  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  final ApiService apiService = ApiService();
  // List<SensorData> data =  apiService.fetchSensorData();
  Monitor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SensorData>>(
      future: apiService.fetchSensorData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: SpinKitFadingCircle(
            color: Colors.green[600],
            size: 50.0,
          ));
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          final sensorDataList = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Soil Monitoring'),
              backgroundColor: Colors.green[600],
              actions: [
                IconButton(
                  icon: const Icon(Icons.history),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            HistoryPage(historyList: sensorDataList ?? []),
                      ),
                    );
                  },
                ),
                IconButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChartsPage(historyList: sensorDataList ?? []),
                        ),
                      );
                    },
                    icon: const Icon(Icons.bar_chart)),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildSensorCard(
                      title: 'Temperature',
                      value:
                          '${sensorDataList?.isNotEmpty == true ? roundDouble(double.parse(sensorDataList![0].temperature), 2) : 'N/A'}°C',
                      icon: Icons.thermostat_outlined,
                    ),
                    const SizedBox(height: 16),
                    buildSensorCard(
                      title: 'Moisture',
                      value:
                          '${sensorDataList?.isNotEmpty == true ? roundDouble(double.parse(sensorDataList![0].soilMoisture), 2) : 'N/A'}%',
                      icon: Icons.opacity_outlined,
                    ),
                    const SizedBox(height: 16),
                    buildSensorCard(
                      title: 'Salinity',
                      value:
                          '${sensorDataList?.isNotEmpty == true ? roundDouble(double.parse(sensorDataList![0].soilSalinity), 2) : 'N/A'}',
                      icon: Icons.grain_outlined,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
