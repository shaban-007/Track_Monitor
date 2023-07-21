import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tracking_history/Classes/Historyclass.dart';

class ApiService {
  static const String apiUrl =
      'https://beta.masterofthings.com/AgricultureWebService?DriverManagerId=1&DriverManagerPassword=123&username=AbrarKotb&password=123';

  Future<List<SensorData>> fetchSensorData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final sensorDataList = jsonData['sensorData'] as List<dynamic>;
      return SensorData.fromJsonList(sensorDataList);
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
