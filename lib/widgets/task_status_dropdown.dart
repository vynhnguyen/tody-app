import 'package:flutter/material.dart';

import '../models/Task.dart';

class TaskStatusDropdown extends StatelessWidget {
  final InputDecoration? customDecoration;
  final TaskStatus status;
  final ValueChanged<TaskStatus> onChanged;

  const TaskStatusDropdown(
      {super.key,
      this.customDecoration,
      required this.status,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<TaskStatus>(
      decoration:
          customDecoration ?? const InputDecoration(labelText: 'Status'),
      value: status,
      items: TaskStatus.values.map((item) {
        final colorStatus = item == TaskStatus.done
            ? Colors.green
            : item == TaskStatus.doing
                ? Colors.blue
                : Colors.yellow[800];
        return DropdownMenuItem<TaskStatus>(
          value: item,
          child: Text(
            item.toShortString(),
            style: TextStyle(color: colorStatus, fontWeight: FontWeight.w600),
          ), // Display enum name
        );
      }).toList(),
      onChanged: (TaskStatus? newValue) {
        onChanged(newValue!);
      },
      validator: (value) => value == null ? 'Please select a status' : null,
    );
  }
}
