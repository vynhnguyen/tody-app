import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/screens/my_profile_screen.dart';
import 'package:todo_app/widgets/manage_task_form.dart';

import '../models/Task.dart';
import '../widgets/task_status_dropdown.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key, required this.title});

  final String title;

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  int _counter = 0;
  Task? selectedTask;

  void _showTaskDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const AlertDialog(
            title: Text('Manage task'),
            content: ManageTaskForm(),
            actions: <Widget>[],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today',
                  style: GoogleFonts.beVietnamPro(
                    textStyle: Theme.of(context).textTheme.displayLarge,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text('Start to manage your tasks',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Theme.of(context).disabledColor))
              ],
            ),
            centerTitle: false,
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyProfileScreen()));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/img/avatar-1.png',
                          width: 40,
                          height: 40,
                          fit: BoxFit.contain,
                        ),
                      ))),
            ],
            toolbarHeight: 70,
            bottom: const TabBar(
              tabs: [
                Tab(text: 'To Do'),
                Tab(text: 'In Progress'),
                Tab(text: 'Done'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              TaskList(status: TaskStatus.todo),
              TaskList(status: TaskStatus.doing),
              TaskList(status: TaskStatus.done),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: 'Increment',
            onPressed: _showTaskDialog,
            child: const Icon(Icons.add),
          ),
        ));
  }
}

class TaskList extends StatelessWidget {
  final TaskStatus status;

  const TaskList({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(builder: (context, provider, child) {
      final tasks = provider.getTasksFilter(status);

      if (tasks.isEmpty) {
        return const Center(
            child: Text('No data', style: TextStyle(color: Colors.grey)));
      }

      return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          final isTaskDone = task.status == TaskStatus.done;

          return Dismissible(
              key: Key(task.id),
              onDismissed: ((direction) {
                provider.removeTask(task.id);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Task was removed!')));
              }),
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              child: Card(
                elevation: 1,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Checkbox(
                        key: Key(task.id),
                        value: isTaskDone,
                        onChanged: (bool? isChecked) {
                          provider.changeStatus(task,
                              isChecked! ? TaskStatus.done : TaskStatus.todo);
                        },
                      ),
                      title: Text(
                        task.title,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            decoration:
                                isTaskDone ? TextDecoration.lineThrough : null),
                      ),
                      subtitle: Text(
                        task.description ?? '--',
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat('dd-MMM-yyyy kk:mm')
                                .format(task.dateTime),
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[600]),
                          ),
                          SizedBox(
                              width: 80,
                              child: TaskStatusDropdown(
                                key: Key(task.id),
                                customDecoration: const InputDecoration(
                                    border: InputBorder.none),
                                status: task.status,
                                onChanged: (TaskStatus status) {
                                  provider.changeStatus(task, status);
                                },
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        },
      );
    });
  }
}

class TabBarViewItem extends StatelessWidget {
  final int counter;

  const TabBarViewItem({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '$counter',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
