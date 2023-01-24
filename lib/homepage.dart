import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskManager'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => GoRouter.of(context).go('/add')),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
