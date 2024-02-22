import 'package:flutter/material.dart';

import '../api/gemini_api.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late TextEditingController _messageController;
  Future<String>? _geminiResponse; // nullable future
  late List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    String userMessage = _messageController.text;
    setState(() {
      _messages.add(Message(text: userMessage, isUser: true));
      _geminiResponse = GeminiAPI.getGeminiData(userMessage);
      _messageController.clear(); // Clear text after message is sent
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gemini Chat'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (BuildContext context, int index) {
                  Message message = _messages[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      '${message.isUser ? 'You: ' : 'AI: '}${message.text}',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<String>(
                future: _geminiResponse,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.hasData) {
                      _messages.add(Message(text: snapshot.data!, isUser: false));
                      return SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'AI: ${snapshot.data!}',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text(
                        'Error fetching data: ${snapshot.error}',
                        style: TextStyle(fontSize: 18.0, color: Colors.red),
                      );
                    } else {
                      return Text(
                        'Please Talk me ',
                        style: TextStyle(fontSize: 18.0),
                      );
                    }
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _sendMessage,
                  child: Text('Send'),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class Message {
  final String text;
  final bool isUser;

  Message({required this.text, required this.isUser});
}