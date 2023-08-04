import 'package:flutter/material.dart';
import 'package:tracking_history/widgets/maps.dart';

class Cars extends StatefulWidget {
  static const routeName = '/car';
  const Cars({super.key});

  @override
  State<Cars> createState() => _CarsState();
}

class _CarsState extends State<Cars> {
  String _selectedAction = 'Car 1';
  List<String> _selectedDays = [];

  final List<String> _actions = ['Car 1', 'Car 2', 'Car 3'];

  final Map<String, List<String>> _actionDaysMap = {
    'Car 1': ['Monday', 'Tuesday', 'Wednesday'],
    'Car 2': ['Thursday', 'Friday'],
    'Car 3': ['Saturday', 'Sunday'],
  };

  @override
  void initState() {
    super.initState();
    _selectedDays = _actionDaysMap[_selectedAction] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: const Text('AppBar with Actions'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String action) {
              setState(() {
                _selectedAction = action;
                _selectedDays = _actionDaysMap[action] ?? [];
              });
            },
            itemBuilder: (BuildContext context) {
              return _actions.map((String action) {
                return PopupMenuItem<String>(
                  value: action,
                  child: Text(action),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _selectedDays.length,
        itemBuilder: (context, index) {
          final day = _selectedDays[index];
          return ListTile(
            title: Text(_selectedDays[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Mape(day, _selectedAction),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
