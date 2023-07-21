import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DetailPage(),
    );
  }
}

class DetailPage extends StatelessWidget {
  const DetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: Text('Smart Irrigation'),
        leading: SizedBox(
          width: 48,
          height: 48,
          child: Image.asset('assets/loaging.gif'),
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
