import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  final _textFieldValueHolder = TextEditingController();
  Widget buildDate() {
    return TextField(
      decoration: InputDecoration(
        hintText: DateFormat.yMMMMd().format(DateTime.now()),
        labelText: "Date",
        border: const OutlineInputBorder(),
      ),
      textInputAction: TextInputAction.next,
      readOnly: true,
      controller: _textFieldValueHolder,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context, //context of current state
            initialDate: DateTime.now(),
            firstDate: DateTime(
                2000), //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2101));

        if (pickedDate != null) {
          setState(() {
            task.date = pickedDate;
            _textFieldValueHolder.text = DateFormat.yMMMMd().format(pickedDate);
          });
        }
      },
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
          value: pendingTasks[index].priority,
          items: const [
            DropdownMenuItem(value: 'High', child: Text('High')),
            DropdownMenuItem(value: 'Medium', child: Text('Medium')),
            DropdownMenuItem(value: 'Low', child: Text('Low')),
          ],
          icon: const Icon(Icons.arrow_drop_down_circle),
          onChanged: (value) {
            setState(() {
              task.priority = value as String;
              pendingTasks[index].priority = value;
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
    if (task.title == "") task.title = pendingTasks[index].title;
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
