import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    home: ProfilePage(),
  ));
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late SharedPreferences _prefs;
  late String name;
  late String age;
  late String userName;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = _prefs.getString('userName') ?? 'Username';
      name = _prefs.getString('name') ?? 'Dr. Milka Johns';
      age = _prefs.getString('age') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50.0,
                child: Icon(
                  Icons.face_retouching_natural_rounded,
                  size: 70.0,
                  color: Colors.white,
                ),
                backgroundColor: Colors.transparent,
              ),
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Your BMI is 23.84',
                style: TextStyle(
                  fontFamily: 'SourceSansPro',
                  color: Colors.white,
                  fontSize: 20.0,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
                width: 150.0,
                child: Divider(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ProfileButton(
                text: 'General Information',
                icon: Icons.info,
                onPressed: () {
                  _showGeneralInfoDialog(context);
                },
              ),
              ProfileButton(
                text: 'Measurement',
                icon: Icons.straighten,
                onPressed: () {
                  _showMeasurementDialog(context);
                },
              ),
              ProfileButton(
                text: 'Health History',
                icon: Icons.favorite,
                onPressed: () {
                  _showHealthHistoryDialog(context);
                },
              ),
              ProfileButton(
                text: 'Medical Procedures',
                icon: Icons.local_hospital,
                onPressed: () {
                  _showMedicalProceduresDialog(context);
                },
              ),
              ProfileButton(
                text: 'Appointments',
                icon: Icons.calendar_today,
                onPressed: () {
                  _showAppointmentDialog(context);
                },
              ),
              ProfileButton(
                text: 'Documents',
                icon: Icons.folder,
                onPressed: () {
                  _showDocumentsDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showGeneralInfoDialog(BuildContext context) {
    TextEditingController _nameController = TextEditingController(text: name);
    TextEditingController _ageController = TextEditingController(text: age);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("General Information"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(hintText: "Name"),
                ),
                TextField(
                  controller: _ageController,
                  decoration: InputDecoration(hintText: "Age"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Save"),
              onPressed: () {
                setState(() {
                  name = _nameController.text.isNotEmpty ? _nameController.text : 'Dr. Milka Johns';
                  age = _ageController.text;
                  userName = name;
                });
                _prefs.setString('name', name);
                _prefs.setString('age', age);
                _prefs.setString('userName', userName);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  _showMeasurementDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Measurement"),
          content: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: "Height"),
              ),
              TextField(
                decoration: InputDecoration(hintText: "Weight"),
              ),
              TextField(
                decoration: InputDecoration(hintText: "Age"),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _showHealthHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Health History"),
          content: SingleChildScrollView(
            child: TextField(
              decoration: InputDecoration(hintText: "Enter Your Past Illnesses"),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _showMedicalProceduresDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Medical Procedures"),
          content: TextField(
            decoration: InputDecoration(hintText: "Enter Performed Medical Procedures"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _showAppointmentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Appointments"),
          content: TextField(
            decoration: InputDecoration(hintText: "Name of the Last Doctor Visited and Reason"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _showDocumentsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Documents"),
          content: TextField(
            decoration: InputDecoration(hintText: "Upload Your Documents"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class ProfileButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onPressed;

  ProfileButton({required this.text, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 30.0,
        ),
        label: Text(
          text,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
      ),
    );
  }
}
