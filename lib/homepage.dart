import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

// classes
import 'package:task_manager_app/update_task.dart';
import './homepage/custom_search_delegate.dart';

// models
import './models/task.dart';

// data
import './data/pending_tasks.dart';
import './data/completed_tasks.dart';

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

  Future<void> _actionOnTap(index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateTask(id: '$index'),
      ),
    );
    if (result) {
      pendingTasks.remove(pendingTasks[index]);
    }
    setState(() {});
  }

  Widget _buildList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: ListView.builder(
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
              _actionOnTap(index);
              // GoRouter.of(context).go('/update/$index');
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
      ),
    );
  }

  // List<int> matchQuery = [for (var i = 0; i < pendingTasks.length; i++) i];

  // void search(query) {
  //   setState(() {
  //     if (query.isEmpty) {
  //       matchQuery = [for (var i = 0; i < pendingTasks.length; i++) i];
  //     } else {
  //       matchQuery = [];
  //       for (int i = 0; i < pendingTasks.length; i++) {
  //         if (pendingTasks[i]
  //             .title
  //             .toLowerCase()
  //             .contains(query.toLowerCase())) {
  //           matchQuery.add(i);
  //         }
  //       }
  //     }
  //   });
  // }

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
              onPressed: ((() async {
                await showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
                setState(() {});
              })),
              icon: const Icon(Icons.search)),
        ],
      ),
      body: Column(
        children: <Widget>[
          // Padding(
          //   padding: const EdgeInsets.symmetric(
          //     horizontal: 27,
          //     vertical: 10,
          //   ),
          //   child:
          //   TextField(
          //     decoration: InputDecoration(
          //       contentPadding: const EdgeInsets.symmetric(
          //         horizontal: 10,
          //         vertical: 10,
          //       ),
          //       hintText:
          //           "You have [ ${pendingTasks.length} ] pending task out of [ ${pendingTasks.length} ]",
          //       labelText: "Search",
          //       border: const OutlineInputBorder(),
          //     ),
          //     textInputAction: TextInputAction.search,
          //     onTap: (() => CustomSearchDelegate()),
          //     onChanged: ((value) {
          //       search(value);
          //     }),
          //   ),
          // ),
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
