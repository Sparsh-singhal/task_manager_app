import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
// import 'package:task_manager_app/data/completed_tasks.dart';
// import 'package:task_manager_app/data/pending_tasks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

// providers
import './providers/pending_tasks_provider.dart';
import './providers/completed_tasks_provider.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  void _remove(int index) {
    // setState(() {
    //   completedTasks.remove(task);
    //   pendingTasks.add(task);
    // });
    context
        .read<PendingTasks>()
        .addTask(context.read<CompletedTasks>().completedTasks[index]);
    context.read<CompletedTasks>().deleteTask(index);
  }

  Widget _buildList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: ListView.builder(
        itemCount: context.watch<CompletedTasks>().completedTasks.length,
        itemBuilder: ((context, int index) {
          return ListTile(
              title: Text(
                  context.watch<CompletedTasks>().completedTasks[index].title),
              subtitle: Row(
                children: [
                  Text(
                    "${DateFormat.MMMM().format(context.watch<CompletedTasks>().completedTasks[index].date)} ${DateFormat.d().format(context.watch<CompletedTasks>().completedTasks[index].date)}, ${DateFormat.y().format(context.watch<CompletedTasks>().completedTasks[index].date)}",
                  ),
                  const Text(' • '),
                  Text(context
                      .watch<CompletedTasks>()
                      .completedTasks[index]
                      .priority),
                ],
              ),
              trailing: IconButton(
                onPressed: () {
                  Fluttertoast.showToast(
                    msg: "Task Reassigned",
                    backgroundColor: Colors.grey,
                  );
                  _remove(index);
                },
                icon: const Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                ),
              ));
        }),
      ),
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
