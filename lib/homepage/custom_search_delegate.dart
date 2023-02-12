import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '../data/pending_tasks.dart';
import 'package:task_manager_app/update_task.dart';

// providers
import '../providers/pending_tasks_provider.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var task in context.watch<PendingTasks>().pendingTasks) {
      if (task.title.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(task.title);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(matchQuery[index]));
      },
    );
  }

  Future<void> actionOnTap(context, index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateTask(id: '$index'),
      ),
    );
    if (result) {
      context.read<PendingTasks>().deleteTask(index);
      // pendingTasks.remove(pendingTasks[index]);
    }
    buildResults(context);
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var task in context.watch<PendingTasks>().pendingTasks) {
      if (task.title.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(task.title);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
          onTap: (() => actionOnTap(context, index)),
        );
      },
    );
  }
}
