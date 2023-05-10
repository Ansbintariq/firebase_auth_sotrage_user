import 'package:flutter/material.dart';

import '../home_screen/widget/mian_drawer.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("second"),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Column(
          children: [const Text("data")],
        ),
      ),
    );
  }
}
