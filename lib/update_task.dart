import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import './data/pending_tasks.dart';

class UpdateTask extends StatefulWidget {
  final String id;
  const UpdateTask({super.key, required this.id});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  int get index => int.parse(widget.id);

  Widget buildTitle() {
    return TextField(
      decoration: InputDecoration(
        hintText: pendingTasks[index].title,
        labelText: 'Title',
        border: const OutlineInputBorder(),
      ),
      textInputAction: TextInputAction.next,
    );
  }

  Widget buildDate() {
    return InputDecorator(
      decoration: InputDecoration(
        hintText: "${pendingTasks[index].date}",
        labelText: 'Date',
        border: const OutlineInputBorder(),
      ),
    );
  }

  String? _val;

  Widget buildPriority() {
    return InputDecorator(
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 7,
        ),
        labelText: 'Priority',
        border: OutlineInputBorder(),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: Text(pendingTasks[index].priority),
          value: _val,
          items: const [
            DropdownMenuItem(value: 'High', child: Text('High')),
            DropdownMenuItem(value: 'Medium', child: Text('Medium')),
            DropdownMenuItem(value: 'Low', child: Text('Low')),
          ],
          icon: const Icon(Icons.arrow_drop_down_circle),
          onChanged: (value) {
            setState(() {
              _val = value;
            });
          },
        ),
      ),
    );
  }

  Future<void> _deleteTask() async {
    // print("deleted $index");
    await (() => GoRouter.of(context).go('/'));
    setState(() {
      pendingTasks.remove(pendingTasks[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Task"),
        leading: IconButton(
          onPressed: (() => GoRouter.of(context).go('/')),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(32.0),
          children: [
            buildTitle(),
            const SizedBox(height: 24),
            buildDate(),
            const SizedBox(height: 24),
            buildPriority(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: (() => print('hi')),
              child: const Text('Update'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: (() => _deleteTask()),
              child: const Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
