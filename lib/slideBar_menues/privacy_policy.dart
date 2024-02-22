import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatefulWidget {
  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  String privacyPolicyText = '''
This privacy policy provides information about the collection, use, and disclosure of personal information related to the HealthPub application.

Collection and Use of Personal Information

When you use our application, we may collect certain personal information, including your name, email address, phone number, and health-related information. We may use this information to provide services to you, manage your account, provide support, and improve the user experience.

Disclosure of Personal Information

We will never sell, rent, or disclose your personal information to others for commercial purposes. However, there may be situations where we need to share information with third-party service providers to provide our services or to meet legal requirements. In such cases, we will share your personal information while taking necessary measures to protect your privacy.

Privacy and Security

We use industry standards and best practices to protect your personal information. However, communication over the internet or electronic storage may not be entirely secure. Therefore, we recommend being cautious when providing your personal information to us through any method.

Children's Privacy

Children under the age of 18 must obtain permission from their parents to use our application. We do not knowingly collect personal information from children under the age of 18.

Changes to the Privacy Policy

This privacy policy may be updated considering changes in our application. When a new version is released, we will use appropriate methods to notify you of the changes.

Contact

If you have any questions or concerns regarding our privacy policy, please feel free to contact us.

HealthPub

Turkey

This privacy policy is effective as of February 22, 2024
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(
          privacyPolicyText,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PrivacyPolicyPage(),
  ));
}
