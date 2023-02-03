import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_app/data/pending_tasks.dart';
import 'package:task_manager_app/models/task.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Task'),
          leading: IconButton(
            onPressed: () => GoRouter.of(context).go('/'),
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: const Center(
          child: Form(),
        ));
  }
}

class Form extends StatefulWidget {
  const Form({
    Key? key,
  }) : super(key: key);

  @override
  State<Form> createState() => _FormState();
}

class _FormState extends State<Form> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String? _val = "High";

  var task = Task(
    title: "Send an email to the team",
    date: DateTime.now(),
    priority: "Low",
  );

  Widget buildTitle() {
    return TextField(
      decoration: const InputDecoration(
        hintText: "Send an email to the team",
        labelText: "Title",
        border: OutlineInputBorder(),
      ),
      textInputAction: TextInputAction.next,
      onSubmitted: ((value) {
        setState(() {
          task.title = value;
        });
      }),
    );
  }

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
          onChanged: ((String? value) {
            setState(() {
              _val = value;
            });
          }),
          value: _val,
          items: const [
            DropdownMenuItem(value: 'High', child: Text('High')),
            DropdownMenuItem(value: 'Medium', child: Text('Medium')),
            DropdownMenuItem(value: 'Low', child: Text('Low')),
          ],
        ),
      ),
    );
  }

  void _submit() {
    setState(() {
      pendingTasks.add(task);
    });
    GoRouter.of(context).go('/');
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 40,
      ),
      children: <Widget>[
        // Form(
        //   key: _formKey,
        // )
        buildTitle(),
        const SizedBox(height: 40),
        buildPriority(),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: _submit,
          child: const Text("Add"),
        )
      ],
    );
  }
}
