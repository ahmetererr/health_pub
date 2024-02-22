import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SettingsOnePage extends StatefulWidget {
  static const String path = "lib/src/pages/settings/settings1.dart";

  const SettingsOnePage({Key? key}) : super(key: key);

  @override
  _SettingsOnePageState createState() => _SettingsOnePageState();
}

class _SettingsOnePageState extends State<SettingsOnePage> {
  late bool _dark;
  bool _receiveNotifications = true;
  bool _receiveNewsletter = false;
  bool _receiveOfferNotifications = true;
  bool _receiveAppUpdates = true;

  @override
  void initState() {
    super.initState();
    _dark = false;
  }

  Brightness _getBrightness() {
    return _dark ? Brightness.dark : Brightness.light;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: _getBrightness(),
      ),
      child: Scaffold(
        backgroundColor: _dark ? null : Colors.grey.shade200,
        appBar: AppBar(
          elevation: 0,
          systemOverlayStyle:
          _dark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
          iconTheme:
          IconThemeData(color: _dark ? Colors.white : Colors.black),
          backgroundColor: Colors.transparent,
          title: Text(
            'Settings',
            style: TextStyle(color: _dark ? Colors.white : Colors.black),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.nights_stay_sharp),
              onPressed: () {
                setState(() {
                  _dark = !_dark;
                });
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.green,
                child: ListTile(
                  onTap: () {
                    // open edit profile
                  },
                  title: const Text(
                    "Vedat Ayaz",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leading: CircleAvatar(),
                  trailing: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Card(
                elevation: 4.0,
                margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: <Widget>[
                    _buildListTile(
                      Icons.lock_outline,
                      "Change Password",
                          () {
                        // open change password
                      },
                    ),
                    _buildDivider(),
                    _buildListTile(
                      Icons.language,
                      "Change Language",
                          () {
                        // open change language
                      },
                    ),
                    _buildDivider(),
                    _buildListTile(
                      Icons.location_on,
                      "Change Location",
                          () {
                        // open change location
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                "Notification Settings",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              _buildSwitchListTile(
                "Received notification",
                _receiveNotifications,
                    (val) {
                  setState(() {
                    _receiveNotifications = val!;
                    // Add your code to enable/disable notifications
                  });
                },
              ),
              _buildSwitchListTile(
                "Received newsletter",
                _receiveNewsletter,
                    (val) {
                  setState(() {
                    _receiveNewsletter = val!;
                    // Add your code to enable/disable newsletter
                  });
                },
              ),
              _buildSwitchListTile(
                "Received Offer Notification",
                _receiveOfferNotifications,
                    (val) {
                  setState(() {
                    _receiveOfferNotifications = val!;
                    // Add your code to enable/disable offer notifications
                  });
                },
              ),
              _buildSwitchListTile(
                "Received App Updates",
                _receiveAppUpdates,
                    (val) {
                  setState(() {
                    _receiveAppUpdates = val!;
                    // Add your code to enable/disable app updates
                  });
                },
              ),
              const SizedBox(height: 60.0),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // log out
          },
          child: const Icon(Icons.power_settings_new),
          backgroundColor: Colors.lightGreen,
        ),
      ),
    );
  }

  ListTile _buildListTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.blue,
      ),
      title: Text(title),
      trailing: const Icon(Icons.keyboard_arrow_right),
      onTap: onTap,
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      width: double.infinity,
      height: 1.0,
      color: Colors.green.shade400,
    );
  }

  SwitchListTile _buildSwitchListTile(
      String title, bool value, ValueChanged<bool?> onChanged) {
    return SwitchListTile(
      activeColor: Colors.lightGreen,
      contentPadding: const EdgeInsets.all(0),
      value: value,
      title: Text(title),
      onChanged: onChanged,
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SettingsOnePage(),
  ));
}