import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_app/models/task.dart';
import './data/pending_tasks.dart';

class UpdateTask extends StatefulWidget {
  final String id;
  const UpdateTask({super.key, required this.id});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  int get index => int.parse(widget.id);

  var task = Task(
    title: "",
    date: DateTime.now(),
    priority: "High",
  );

  Widget buildTitle() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: pendingTasks[index].title,
        labelText: 'Title',
        border: const OutlineInputBorder(),
      ),
      initialValue: pendingTasks[index].title,
      textInputAction: TextInputAction.next,
      onChanged: ((value) {
        setState(() {
          task.title = value;
        });
      }),
    );
  }

  Widget buildDate() {
    // return InputDecorator(
    //   decoration: InputDecoration(
    //     hintText: "${pendingTasks[index].date}",
    //     labelText: 'Date',
    //     border: const OutlineInputBorder(),
    //   ),
    // );
    return TextField(
      decoration: const InputDecoration(
        hintText: "01/01/2023",
        labelText: "Date",
        border: OutlineInputBorder(),
      ),
      textInputAction: TextInputAction.next,
      onSubmitted: ((value) {
        setState(() {
          task.date = DateTime.now();
        });
      }),
    );
  }

  // String? _val;

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
          value: pendingTasks[index].priority,
          items: const [
            DropdownMenuItem(value: 'High', child: Text('High')),
            DropdownMenuItem(value: 'Medium', child: Text('Medium')),
            DropdownMenuItem(value: 'Low', child: Text('Low')),
          ],
          icon: const Icon(Icons.arrow_drop_down_circle),
          onChanged: (value) {
            setState(() {
              pendingTasks[index].priority = value as String;
            });
          },
        ),
      ),
    );
  }

  void _deleteTask() {
    // print("deleted $index");
    // GoRouter.of(context).go('/');
    Navigator.pop(context, true);
    // setState(() {
    //   pendingTasks.remove(pendingTasks[index]);
    // });
  }

  void _submitUpdatedTask() {
    // GoRouter.of(context).go('/');
    setState(() {
      pendingTasks[index] = task;
    });
    Navigator.pop(context, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Task"),
        leading: IconButton(
          onPressed: ((() => Navigator.pop(context, false))),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          children: [
            buildTitle(),
            const SizedBox(height: 40),
            buildDate(),
            const SizedBox(height: 40),
            buildPriority(),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: (() => _submitUpdatedTask()),
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
