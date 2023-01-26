import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_app/data/completed_tasks.dart';

// models
import './models/task.dart';

// data
import './data/pending_tasks.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _remove(Task task) {
    setState(() {
      pendingTasks.remove(task);
      completedTasks.add(task);
    });
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: pendingTasks.length,
      itemBuilder: (context, int index) {
        return ListTile(
          title: Text(pendingTasks[index].title),
          subtitle: Row(
            children: [
              Text(
                  "${DateFormat.MMMM().format(pendingTasks[index].date)} ${DateFormat.d().format(pendingTasks[index].date)}, ${DateFormat.y().format(pendingTasks[index].date)}"),
              const Text(' • '),
              Text(pendingTasks[index].priority),
            ],
          ),
          onTap: (() {
            print(index);
            GoRouter.of(context).go('/update/$index');
          }),
          trailing: IconButton(
            onPressed: () {
              Fluttertoast.showToast(
                msg: "Task completed",
                backgroundColor: Colors.grey,
              );
              _remove(pendingTasks[index]);
            },
            icon: const Icon(Icons.check_box_outline_blank),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.grid_view_rounded),
        title: const Text('TaskManager'),
        actions: <Widget>[
          IconButton(
            onPressed: (() => GoRouter.of(context).go('/history')),
            icon: const Icon(Icons.history),
          ),
          IconButton(
              onPressed: ((() =>
                  print('Settings have been clicked on homepage!'))),
              icon: const Icon(Icons.settings_outlined))
        ],
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              "You have [ ${pendingTasks.length} ] pending task out of [ ${pendingTasks.length} ]",
            ),
          ),
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
