import 'package:flutter/material.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: const SafeArea(
        child: Text(
            'Ooh! You seem pretty excited to add task. Wait for it... Wait for it...'),
      ),
    );
  }
}
