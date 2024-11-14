import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/task_provider.dart';
import '../models/Task.dart';
import 'task_status_dropdown.dart';

class ManageTaskForm extends StatefulWidget {
  const ManageTaskForm({super.key});

  @override
  State<ManageTaskForm> createState() => _ManageTaskFormState();
}

class _ManageTaskFormState extends State<ManageTaskForm> {
  final _formKey = GlobalKey<FormState>();
  String id = '';
  String title = '';
  String description = '';
  DateTime dateTime = DateTime.now();
  TaskStatus status = TaskStatus.todo;

  void _submitForm() {
    if (_formKey.currentState!.validate() == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Can not add task')),
      );
    }

    _formKey.currentState!.save();
    var task = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: description,
        status: status,
        dateTime: dateTime);
    Provider.of<TaskProvider>(context, listen: false).addTask(task);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        canPop: true,
        child: Column(
          children: [
            TextFormField(
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter title';
                }
                return null;
              },
              onSaved: (newValue) => title = newValue!,
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              maxLines: 2,
              decoration: const InputDecoration(labelText: 'Description'),
              onSaved: (newValue) => description = newValue!,
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Date', hintText: 'yyyy-MM-dd'),
              keyboardType: TextInputType.datetime,
              initialValue: dateTime.toString(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter date';
                }
                if (DateTime.tryParse(value) == null) {
                  return 'Please enter a valid date';
                }
                return null;
              },
              onSaved: (value) => dateTime = DateTime.parse(value!),
            ),
            const SizedBox(
              height: 8,
            ),
            TaskStatusDropdown(
              status: status,
              onChanged: (TaskStatus value) {
                setState(() {
                  status = value;
                });
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel')),
                const SizedBox(
                  width: 20,
                ),
                FilledButton(
                  onPressed: _submitForm,
                  child: const Text('Submit'),
                )
              ],
            ),
          ],
        ));
  }
}
