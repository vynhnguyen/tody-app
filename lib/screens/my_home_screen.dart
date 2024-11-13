import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/widgets/manage_task_form.dart';

import '../models/Task.dart';

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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/img/avatar-1.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
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
          body: Consumer<TaskProvider>(builder: (context, provider, child) {
            return TabBarView(
              children: [
                TaskList(tasks: provider.tasks),
                TaskList(tasks: provider.tasks),
                TabBarViewItem(
                  counter: _counter,
                ),
              ],
            );
          }),
          floatingActionButton: FloatingActionButton(
            tooltip: 'Increment',
            onPressed: _showTaskDialog,
            child: const Icon(Icons.add),
          ),
        ));
  }
}

class TaskList extends StatelessWidget {
  final List<Task> tasks;

  const TaskList({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(task.description!),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(DateFormat('dd-MMM-yyyy').format(task.dateTime)),
                    Text(task.status.toShortString())
                  ],
                )
              ],
            ),
            // leading: CheckboxListTile(
            //     value: true,
            //     onChanged: (value) {
            //       print(value);
            //     }),
            // trailing: Text(task.status.toString()),
          );
        },
      ),
    );
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
