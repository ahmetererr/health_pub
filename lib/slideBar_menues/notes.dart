import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<String> notes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: notes.isEmpty
          ? Center(
        child: Text('There are no notes.'),
      )
          : ListView.builder(
        itemCount: notes.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(notes[index]),
              onTap: () {
                // Show editing screen when a note is tapped
                _editNoteDialog(context, index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open dialog for adding a new note
          _showAddNoteDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _showAddNoteDialog(BuildContext context) {
    TextEditingController _noteController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Note'),
          content: TextField(
            controller: _noteController,
            decoration: InputDecoration(labelText: 'Your Note'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Add new note to the list
                setState(() {
                  notes.add(_noteController.text);
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _editNoteDialog(BuildContext context, int index) {
    TextEditingController _editedNoteController =
    TextEditingController(text: notes[index]);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Note'),
          content: TextField(
            controller: _editedNoteController,
            decoration: InputDecoration(labelText: 'Your Note'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Update the note
                setState(() {
                  notes[index] = _editedNoteController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NotesPage(),
  ));
}
