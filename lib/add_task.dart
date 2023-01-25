import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
        leading: IconButton(
          onPressed: () => GoRouter.of(context).go('/'),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: const Text(
          'Ooh! You seem pretty excited to add task. Wait for it... Wait for it...'),
    );
  }
}
