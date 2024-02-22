import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(MaterialApp(
    home: CalendarPage(),
  ));
}

class EventDetails {
  final String eventName;
  final String details;

  EventDetails(this.eventName, this.details);
}

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _currentDay = DateTime.now();
  DateTime _focusDay = DateTime.now();
  CalendarFormat _format = CalendarFormat.month;
  bool _dateSelected = false;
  bool _isWeekend = false;
  bool _timeSelected = false;
  int? _currentIndex;

  Map<DateTime, List<EventDetails>> _eventDetails = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          _buildTableCalendar(),
          SizedBox(height: 20),
          _buildEventList(),
        ],
      ),
    );
  }

  Widget _buildTableCalendar() {
    return Column(
      children: [
        TableCalendar(
          focusedDay: _focusDay,
          firstDay: DateTime.utc(2023, 1, 1),
          lastDay: DateTime.utc(2100, 12, 31),
          calendarFormat: _format,
          currentDay: _currentDay,
          rowHeight: 48,
          calendarStyle: const CalendarStyle(
            todayDecoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
            selectedDecoration: BoxDecoration(color: Colors.lightBlueAccent, shape: BoxShape.circle),
          ),
          availableCalendarFormats: const {
            CalendarFormat.month: 'Month',
          },
          onFormatChanged: (format) {
            setState(() {
              _format = format;
            });
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _currentDay = selectedDay;
              _focusDay = focusedDay;
              _dateSelected = true;

              if (selectedDay.weekday == 6 || selectedDay.weekday == 7) {
                _isWeekend = true;
                _timeSelected = false;
                _currentIndex = null;
              } else {
                _isWeekend = false;
              }
            });

            _showAddEventDialog(context);
          },
          eventLoader: (day) {
            return _eventDetails[day] ?? [];
          },
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                _showDeleteEventsDialog(context);
              },
              child: Text('Delete All Events'),
            ),
            ElevatedButton(
              onPressed: () {
                _showDeleteSingleEventDialog(context);
              },
              child: Text('Delete Single Event'),
            ),
          ],
        ),
      ],
    );
  }
  Widget _buildEventList() {
    DateTime oneWeekLater = _currentDay.add(Duration(days: 7));
    List<EventDetails> upcomingEventDetails = _eventDetails[_currentDay] ?? [];
    List<EventDetails> upcomingWeekEvents = [];

    _eventDetails.forEach((day, details) {
      if (day.isAfter(_currentDay) && day.isBefore(oneWeekLater)) {
        upcomingWeekEvents.addAll(details);
      }
    });

    List<EventDetails> pastEventDetails = [];
    _eventDetails.forEach((day, details) {
      if (day.isBefore(_currentDay)) {
        pastEventDetails.addAll(details);
      }
    });

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Upcoming Events:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            if (_dateSelected && upcomingWeekEvents.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: upcomingWeekEvents
                    .map((event) => GestureDetector(
                  onTap: () {
                    _showEventDetails(event);
                  },
                  child: Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Department: ${event.eventName}'),
                          SizedBox(height: 5),
                          Text('Complaints: ${event.details}'),
                        ],
                      ),
                    ),
                  ),
                ))
                    .toList(),
              ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Past Events:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            if (pastEventDetails.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: pastEventDetails
                    .map((event) => GestureDetector(
                  onTap: () {
                    _showEventDetails(event);
                  },
                  child: Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Department: ${event.eventName}'),
                          SizedBox(height: 5),
                          Text('Details: ${event.details}'),
                        ],
                      ),
                    ),
                  ),
                ))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddEventDialog(BuildContext context) async {
    String newEventName = '';
    String newEventDetails = '';
    String newEventDoctor = '';
    TimeOfDay? selectedTime;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create New Hospital Appointment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  newEventName = value;
                },
                decoration: InputDecoration(hintText: 'Department to Visit'),
              ),
              TextField(
                onChanged: (value) {
                  newEventDetails = value;
                },
                decoration: InputDecoration(hintText: 'Your Complaints'),
              ),
              TextField(
                onChanged: (value) {
                  newEventDoctor = value;
                },
                decoration: InputDecoration(hintText: 'Doctor Information'),
              ),
              ListTile(
                title: Text('Appointment Time'),
                trailing: Icon(Icons.access_time),
                onTap: () async {
                  selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (newEventName.isNotEmpty &&
                    newEventDetails.isNotEmpty &&
                    newEventDoctor.isNotEmpty &&
                    selectedTime != null) {
                  _addEvent(
                    _currentDay,
                    EventDetails(
                      newEventName,
                      '$newEventDoctor\n$newEventDetails\n${selectedTime!.format(context)}',
                    ),
                  );
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
  Future<void> _showDeleteEventsDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete All Events'),
          content: Text('Are you sure you want to delete all events?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteAllEvents();
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDeleteSingleEventDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete a Single Event'),
          content: Text('There is an event on this date, do you want to delete it?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteSingleEvent(_currentDay);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _deleteAllEvents() {
    setState(() {
      _eventDetails.clear();
      _dateSelected = false;
    });
  }

  void _deleteSingleEvent(DateTime day) {
    setState(() {
      _eventDetails.remove(day);
      if (_eventDetails.isEmpty) {
        _dateSelected = false;
      }
    });
  }
  void _showEventDetails(EventDetails event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(event.eventName),
          content: Text(event.details),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _addEvent(DateTime day, EventDetails event) {
    setState(() {
      _eventDetails.update(
        day,
            (value) => [...value, event],
        ifAbsent: () => [event],
      );
      _dateSelected = true;
    });
  }
}
