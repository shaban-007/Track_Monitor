import 'package:flutter/material.dart';

import 'package:tracking_history/Classes/ServiceClass.dart';
import '../Classes/Historyclass.dart';
import 'History.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Monitor extends StatelessWidget {
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
              title: Text('Soil Monitoring'),
              backgroundColor: Colors.green[600],
              actions: [
                IconButton(
                  icon: Icon(Icons.history),
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
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildSensorCard(
                      title: 'Temperature',
                      value:
                          '${sensorDataList?.isNotEmpty == true ? sensorDataList![0].temperature : 'N/A'}°C',
                      icon: Icons.thermostat_outlined,
                    ),
                    SizedBox(height: 16),
                    _buildSensorCard(
                      title: 'Humidity',
                      value:
                          '${sensorDataList?.isNotEmpty == true ? sensorDataList![0].soilMoisture : 'N/A'}%',
                      icon: Icons.opacity_outlined,
                    ),
                    SizedBox(height: 16),
                    _buildSensorCard(
                      title: 'Salinity',
                      value:
                          '${sensorDataList?.isNotEmpty == true ? sensorDataList![0].soilSalinity : 'N/A'}',
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

  Widget _buildSensorCard({String? title, String? value, IconData? icon}) {
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
            SizedBox(height: 16),
            Text(
              title!,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              value!,
              style: TextStyle(
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
}
