import 'package:flutter/material.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  List<String> events = [
    'Event 1',
    'Event 2',
    'Event 3',
    // Add more events here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(events[index]),
            subtitle: Text('Description can go here'),
            leading: Icon(Icons.event),
            onTap: () {
              // When you click on the event, the actions to be taken can be viewed here.
            },
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: EventsPage(),
  ));
}
