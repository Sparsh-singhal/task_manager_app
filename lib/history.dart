import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_app/data/completed_tasks.dart';
import 'package:task_manager_app/data/pending_tasks.dart';
import './models/task.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  void _remove(Task task) {
    setState(() {
      completedTasks.remove(task);
      pendingTasks.add(task);
    });
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: completedTasks.length,
      itemBuilder: ((context, int index) {
        return ListTile(
            title: Text(completedTasks[index].title),
            subtitle: Row(
              children: [
                Text(
                  "${DateFormat.MMMM().format(completedTasks[index].date)} ${DateFormat.d().format(completedTasks[index].date)}, ${DateFormat.y().format(completedTasks[index].date)}",
                ),
                const Text(' • '),
                Text(completedTasks[index].priority),
              ],
            ),
            trailing: IconButton(
              onPressed: () => _remove.call(completedTasks[index]),
              icon: const Icon(
                Icons.delete_forever,
                color: Colors.red,
              ),
            ));
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () => GoRouter.of(context).go('/'),
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: const Text("History")),
      body: _buildList(),
    );
  }
}
