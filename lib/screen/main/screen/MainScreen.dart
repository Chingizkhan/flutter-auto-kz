import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main screen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Main screen',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
