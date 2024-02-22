import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/schedule_page.dart';
import 'dashboard.dart';
import 'events.dart';
import 'notes.dart';
import 'package:ecommerce/slideBar_menues/contacts.dart';
import 'package:ecommerce/slideBar_menues/privacy_policy.dart';
import 'package:ecommerce/slideBar_menues/send_feedback.dart';
import 'package:ecommerce/slideBar_menues/settings.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: FutureBuilder<String>(
              future: _loadUserName(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data!,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                } else {
                  return Text('Username');
                }
              },
            ),
            accountEmail: Text(''),
            currentAccountPicture: Center(
              child: CircleAvatar(
                radius: 50.0,
                child: Icon(
                  Icons.face_retouching_natural_rounded,
                  size: 70.0,
                  color: Colors.white,
                ),
                backgroundColor: Colors.transparent,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: AssetImage('assets/images/profile.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          ListTile(
            leading: Icon(Icons.contacts),
            title: Text('Contacts'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactsPage()),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.event),
            title: Text('Events'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalendarPage()),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.note),
            title: Text('Notes'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotesPage()),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Privacy Policy'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.feedback_outlined),
            title: Text('Send Feedback'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SendFeedbackPage()),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsOnePage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<String> _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString('userName');
    return userName ?? 'Username';
  }
}
