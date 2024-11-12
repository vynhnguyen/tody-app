import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
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
                  borderRadius: BorderRadius.circular(22),
                  child: Image.asset(
                    'assets/img/avatar-1.png',
                    width: 44,
                    height: 44,
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
          body: TabBarView(
            children: [
              TabBarViewItem(counter: _counter,),
              const Icon(Icons.directions_transit),
              const Icon(Icons.directions_bike),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ));
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
