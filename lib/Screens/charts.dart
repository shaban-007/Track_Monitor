import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tracking_history/models/Historyclass.dart';
import 'dart:math';

import 'package:tracking_history/models/data.dart';

class ChartsPage extends StatelessWidget {
  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  final List<SensorData> historyList;
  List<chart> d = [];
  ChartsPage({required this.historyList});
  late TooltipBehavior _tooltip = TooltipBehavior(enable: true);

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 10; i++) {
      d.add(
        chart(
          2010 + i,
          double.parse(historyList[i].temperature),
          double.parse(historyList[i].soilMoisture) - (2.6 * i),
          double.parse(historyList[i].soilSalinity) + (1.9 * i),
        ),
      );
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[600],
          title: const Text('History'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(child: Text("temperature")),
              Container(
                width: double.infinity,
                height: 150,
                child: SfCartesianChart(
                  series: <ChartSeries>[
                    SplineSeries<chart, int>(
                        name: "temp",
                        dataSource: d,
                        xValueMapper: (chart data, _) => data.date,
                        yValueMapper: (chart data, _) => data.temp),
                    // SplineSeries<chart, int>(
                    //     name: "temp",
                    //     dataSource: d,
                    //     xValueMapper: (chart data, _) => data.date,
                    //     yValueMapper: (chart data, _) => data.hum)
                  ],
                ),
              ),
              Center(child: Text("soilMoisture")),
              Container(
                width: double.infinity,
                height: 150,
                child: SfCartesianChart(
                  series: <ChartSeries>[
                    SplineSeries<chart, int>(
                        dataSource: d,
                        xValueMapper: (chart data, _) => data.date,
                        yValueMapper: (chart data, _) => data.hum),
                  ],
                ),
              ),
              Center(child: Text("soilSalinity")),
              Container(
                width: double.infinity,
                height: 150,
                child: SfCartesianChart(
                  series: <ChartSeries>[
                    SplineSeries<chart, int>(
                        dataSource: d,
                        xValueMapper: (chart data, _) => data.date,
                        yValueMapper: (chart data, _) => data.sal)
                  ],
                ),
              ),
              Center(child: Text("temperature & soilMoisture")),
              Container(
                width: double.infinity,
                height: 150,
                child: SfCartesianChart(
                  series: <ChartSeries>[
                    SplineSeries<chart, int>(
                        name: "temp",
                        dataSource: d,
                        xValueMapper: (chart data, _) => data.date,
                        yValueMapper: (chart data, _) => data.temp),
                    SplineSeries<chart, int>(
                        name: "temp",
                        dataSource: d,
                        xValueMapper: (chart data, _) => data.date,
                        yValueMapper: (chart data, _) => data.hum)
                  ],
                ),
              ),
              Container(
                child: SfCircularChart(
                  tooltipBehavior: _tooltip,
                  series: <CircularSeries<dynamic, dynamic>>[
                    DoughnutSeries<chart, int>(
                        dataSource: d,
                        xValueMapper: (chart data, _) => data.date,
                        yValueMapper: (chart data, _) => data.hum,
                        name: 'Gold')
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
