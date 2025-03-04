import 'package:flutter/material.dart';
import 'package:hope/chat_screen.dart';

class InboxScreen extends StatefulWidget {
  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final List<Map<String, String>> clients = [
    {"name": "Leo", "message": "Good afternoon", "date": "Jul"},
    {"name": "Levi", "message": "Hello there!", "date": "Aug"},
    {"name": "Shinra", "message": "How's it going?", "date": "Sep"},
    {"name": "Tensei", "message": "Let's meet up.", "date": "Oct"},
  ];

  Map<String, List<Map<String, dynamic>>> conversations = {
    "Leo": [
      {"text": "Hi Ma’am/Sir Good Afternoon", "isSent": false, "time": "2:33pm", "seen": false},
      {"text": "Good Afternoon, How can I help?", "isSent": true, "time": "2:34pm", "seen": false},
    ],
    "Levi": [
      {"text": "Hello there!", "isSent": false, "time": "3:00pm", "seen": false},
      {"text": "Hi! How can I assist you?", "isSent": true, "time": "3:01pm", "seen": true},
    ],
    "Shinra": [
      {"text": "How's it going?", "isSent": false, "time": "4:00pm", "seen": false},
      {"text": "All good! What can I do for you?", "isSent": true, "time": "4:02pm", "seen": false},
    ],
    "Tensei": [
      {"text": "Let's meet up.", "isSent": false, "time": "5:00pm", "seen": true},
      {"text": "Sure! What time works for you?", "isSent": true, "time": "5:02pm", "seen": true},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Inbox"),
      ),
      body: ListView.builder(
        itemCount: clients.length,
        itemBuilder: (context, index) {
          final client = clients[index];
          final String clientName = client["name"]!;
          final bool lastMessageSeen = conversations[clientName]!.last["seen"];

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.black,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text(
              client["name"]!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(client["message"]!),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(client["date"]!, style: TextStyle(fontWeight: FontWeight.bold)),
                Icon(
                  Icons.check,
                  color: lastMessageSeen ? const Color(0xFFFEE500) : Colors.grey,
                ),
              ],
            ),
            onTap: () {
              // Mark all messages as seen when opening chat
              setState(() {
                for (var msg in conversations[clientName]!) {
                  msg["seen"] = true;
                }
              });

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    clientName: clientName,
                    messages: conversations[clientName]!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}