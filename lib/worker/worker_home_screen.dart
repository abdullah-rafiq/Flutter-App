import 'package:flutter/material.dart';

class WorkerHomeScreen extends StatelessWidget {
  const WorkerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Worker home'),
      ),
      body: const Center(
        child: Text('Worker dashboard will be implemented here.'),
      ),
    );
  }
}
