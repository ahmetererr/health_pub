import 'package:flutter/material.dart';

void main() {
  runApp(SymptomCheckerApp());
}

class SymptomCheckerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Symptom Check',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SymptomCheckerScreen(),
    );
  }
}

class SymptomCheckerScreen extends StatefulWidget {
  @override
  _SymptomCheckerScreenState createState() => _SymptomCheckerScreenState();
}

class _SymptomCheckerScreenState extends State<SymptomCheckerScreen> {
  String age = '';
  String gender = '';
  String symptoms = '';
  String possibleDisease = '';
  String department = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Symptom Check'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 20.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter your age',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    age = value;
                  });
                },
              ),
              SizedBox(height: 10.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Your gender',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    gender = value;
                  });
                },
              ),
              SizedBox(height: 10.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter your symptoms',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    symptoms = value;
                  });
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (symptoms.toLowerCase().contains('fever') &&
                        symptoms.toLowerCase().contains('headache') &&
                        symptoms.toLowerCase().contains('runny nose') &&
                        symptoms.toLowerCase().contains('cough') &&
                        symptoms.toLowerCase().contains('fatigue') &&
                        symptoms.toLowerCase().contains('diarrhea')
                    ) {
                      possibleDisease = 'Common cold or flu';
                      department = 'General Practitioner';
                    }
                    if (symptoms.toLowerCase().contains('fever') &&
                        symptoms.toLowerCase().contains('headache') &&
                        symptoms.toLowerCase().contains('cough') &&
                        symptoms.toLowerCase().contains('sore throat') &&
                        symptoms.toLowerCase().contains('fatigue')
                    ) {
                      possibleDisease = 'Throat infection';
                      department = 'General Practitioner';
                    }
                    if (symptoms.toLowerCase().contains('toothache') &&
                        symptoms.toLowerCase().contains('swelling in the tooth')
                    ) {
                      possibleDisease = 'Tooth infection';
                      department = 'Dentistry';
                    }
                    if (symptoms.toLowerCase().contains('bruise') &&
                        symptoms.toLowerCase().contains('swelling') &&
                        symptoms.toLowerCase().contains('knee pain')
                    ) {
                      possibleDisease = 'Fracture or dislocation';
                      department = 'Orthopedics';
                    }
                    if (symptoms.toLowerCase().contains('head injury') &&
                        symptoms.toLowerCase().contains('ear bleeding')
                    ) {
                      possibleDisease = 'Brain hemorrhage';
                      department = 'Neurosurgery';
                    }
                    if (symptoms.toLowerCase().contains('diarrhea') &&
                        symptoms.toLowerCase().contains('bloody urine')
                    ) {
                      possibleDisease = 'Stomach bleeding';
                      department = 'General Surgery';
                    }
                    if (symptoms.toLowerCase().contains('fatigue') &&
                        symptoms.toLowerCase().contains('frequent urination')
                    ) {
                      possibleDisease = 'Prostate';
                      department = 'Urology';
                    }
                    if (symptoms.toLowerCase().contains('redness on the skin') &&
                        symptoms.toLowerCase().contains('fatigue') &&
                        symptoms.toLowerCase().contains('runny nose')
                    ) {
                      possibleDisease = 'Allergy';
                      department = 'Internal Medicine';
                    }
                    if (symptoms.toLowerCase().contains('stomach ache') &&
                        symptoms.toLowerCase().contains('headache') &&
                        symptoms.toLowerCase().contains('high fever') &&
                        symptoms.toLowerCase().contains('rash')
                    ) {
                      possibleDisease = 'Allergy';
                      department = 'Allergy Clinic';
                    }
                    // Add conditions needed for other cases
                  });
                },
                child: Text('Check Symptoms'),
              ),
              SizedBox(height: 20.0),
              Text(
                'When your symptoms are evaluated, your possible illness:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                '$possibleDisease',
                style: TextStyle(fontSize: 18.0, color: Colors.red),
              ),
              SizedBox(height: 20.0),
              Text(
                'In this case, it is recommended to consult a doctor. Which section you should go to:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                '$department',
                style: TextStyle(fontSize: 18.0, color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
