class SensorData {
  final int id;
  final String timestamp;
  final String soilSalinity;
  final String soilMoisture;
  final String temperature;

  SensorData({
    required this.id,
    required this.timestamp,
    required this.soilSalinity,
    required this.soilMoisture,
    required this.temperature,
  });

  factory SensorData.fromJson(Map<String, dynamic> json) {
    return SensorData(
      id: json['id'],
      timestamp: json['TimeStamp'],
      soilSalinity: json['soil_salinity'],
      soilMoisture: json['soil_moisture'],
      temperature: json['Temperature'],
    );
  }

  static List<SensorData> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((jsonData) => SensorData.fromJson(jsonData)).toList();
  }
}
