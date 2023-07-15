import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Car {
  final String name;
  final Map<String, List<LatLng>> days;

  Car(this.name, this.days);
}

class Mape extends StatefulWidget {
  final String day;
  final String name;

  Mape(this.day, this.name);

  @override
  State<Mape> createState() => _MapState();
}

class _MapState extends State<Mape> {
  List<Car> carDatabase = [
    Car(
      'Car 1',
      {
        'Monday': [
          LatLng(30.164907, 31.206471),
          LatLng(30.164896, 31.206421),
          LatLng(30.164896, 31.206356),
          LatLng(30.164894, 31.206305),
          LatLng(30.164894, 31.206254),
          LatLng(30.164952, 31.206248),
        ],
        'Tuesday': [
          LatLng(30.164774, 31.205859),
          LatLng(30.164774, 31.205859),
          LatLng(30.164878, 31.205900),
          LatLng(30.164927, 31.205899),
          LatLng(30.164915, 31.205863),
          LatLng(30.164911, 31.205828),
        ],
        'Wednesday': [
          LatLng(30.165082, 31.205543),
          LatLng(30.165087, 31.205635),
          LatLng(30.165090, 31.205718),
          LatLng(30.165099, 31.205801),
          LatLng(30.165111, 31.205890),
          LatLng(30.165199, 31.205951),
        ],
      },
    ),
    Car(
      'Car 2',
      {
        'Thursday': [
          LatLng(37.432965331129, -122.088323557078792),
          LatLng(37.432966331129, -123.088323557078792),
          LatLng(37.432967331129, -124.088323557078792),
        ],
        'Friday': [
          LatLng(37.432965331129, -122.088323557078792),
          LatLng(37.432966331129, -123.088323557078792),
          LatLng(37.432967331129, -124.088323557078792),
        ],
      },
    ),
  ];

  final Set<Marker> markers = {};
  List<Polyline> polylines = [];
  List<LatLng>? selectedPoints = [];

  @override
  void initState() {
    super.initState();
    getpoints();
    createPolyline();
    print(widget.name);
    print(widget.day);
  }

  void getpoints() {
    Car? selectedCar;
    // Car? selectedCar = carDatabase.firstWhere((car) => car.name == widget.name);
    for (int i = 0; i < carDatabase.length; i++) {
      if (carDatabase[i].name == widget.name) {
        selectedCar = carDatabase[i];
      }
    }
    if (selectedCar != null) {
      selectedPoints = selectedCar.days[widget.day];
    } else {
      selectedPoints = []; // Assign an empty list as the default value
    }
  }

  void createPolyline() {
    polylines.add(
      Polyline(
        polylineId: PolylineId('1'),
        color: Color.fromARGB(255, 252, 5, 5),
        width: 3,
        points: selectedPoints!,
        patterns: [
          PatternItem.dash(10),
          PatternItem.gap(10),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.name}'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: const CameraPosition(
              target: LatLng(30.164986, 31.206028),
              zoom: 19,
            ),
            onMapCreated: (GoogleMapController googleMapController) {},
            markers: markers,
            polylines: polylines.toSet(),
          ),
          Container(
            child: Text("${widget.day}"),
            alignment: Alignment.bottomCenter,
          )
        ],
      ),
    );
  }
}
