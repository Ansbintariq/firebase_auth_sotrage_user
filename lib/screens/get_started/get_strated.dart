import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 300,
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  Get.toNamed("/login");
                },
                child: const Text("welcome")),
          )
        ],
      ),
    );
  }
}
