import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// providers
import './providers/pending_tasks_provider.dart';
import './providers/completed_tasks_provider.dart';

// classes
import 'package:task_manager_app/update_task.dart';
import './homepage/custom_search_delegate.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _remove(int index) {
    context
        .read<CompletedTasks>()
        .addTask(context.read<PendingTasks>().pendingTasks[index]);
    context.read<PendingTasks>().deleteTask(index);
  }

  void _actionOnTap(index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateTask(id: '$index'),
      ),
    );
  }

  Widget _buildList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: ListView.builder(
        itemCount: context.watch<PendingTasks>().pendingTasks.length,
        itemBuilder: (context, int index) {
          return ListTile(
            title:
                Text(context.watch<PendingTasks>().pendingTasks[index].title),
            subtitle: Row(
              children: [
                Text(
                    "${DateFormat.MMMM().format(context.watch<PendingTasks>().pendingTasks[index].date)} ${DateFormat.d().format(context.watch<PendingTasks>().pendingTasks[index].date)}, ${DateFormat.y().format(context.watch<PendingTasks>().pendingTasks[index].date)}"),
                const Text(' • '),
                Text(
                    context.watch<PendingTasks>().pendingTasks[index].priority),
              ],
            ),
            onTap: (() {
              _actionOnTap(index);
            }),
            trailing: IconButton(
              onPressed: () {
                Fluttertoast.showToast(
                  msg: "Task completed",
                  backgroundColor: Colors.grey,
                );
                _remove(index);
              },
              icon: const Icon(Icons.check_box_outline_blank),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(
          Icons.grid_view_rounded,
          color: Colors.black,
        ),
        title: Row(
          children: const [
            Text(
              'Task',
              style: TextStyle(color: Colors.grey),
            ),
            Text('Manager'),
          ],
        ),
        actions: <Widget>[
          IconButton(
            onPressed: (() => GoRouter.of(context).go('/history')),
            icon: const Icon(Icons.history),
          ),
          const Icon(Icons.settings_outlined),
          IconButton(
              onPressed: ((() {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
                // setState(() {});
              })),
              icon: const Icon(Icons.search)),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: _buildList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => GoRouter.of(context).go('/add')),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
