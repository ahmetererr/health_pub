import 'package:flutter/material.dart';

class ContactsPage extends StatelessWidget {
  final List<Map<String, String>> contacts = [
    {"name": "Emre Erkek", "phone": "+905424548086"},
    {"name": "Erdem Musluk", "phone": "+905511357041"},
    {"name": "Alice Johnson", "phone": "+1122334455"},
    // Other contact information can be added here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(contacts[index]['name']!),
            subtitle: Text(contacts[index]['phone']!),
            leading: CircleAvatar(
              child: Text(contacts[index]['name']![0]),
            ),
            onTap: () {
              // Operations to be performed when a contact is tapped can be added here
              // For example, Navigator can be used to navigate to contact details
            },
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ContactsPage(),
  ));
}
