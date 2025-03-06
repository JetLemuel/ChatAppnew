import 'package:flutter/material.dart';
import 'package:hope/chat_screen.dart';

class InboxScreen extends StatefulWidget {
  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final List<Map<String, dynamic>> clients = [
    {"name": "Leo", "date": "Jul"},
    {"name": "Levi", "date": "Aug"},
    {"name": "Shinra", "date": "Sep"},
    {"name": "Tensei", "date": "Oct"},
  ];

  Map<String, List<Map<String, dynamic>>> conversations = {
    "Leo": [
      {"text": "Hi Ma’am/Sir Good Afternoon", "isSent": false, "time": "2:33pm", "seen": false},
      {"text": "Good Afternoon, How can I help?", "isSent": false, "time": "2:34pm", "seen": false},
    ],
    "Levi": [
      {"text": "Hello there!", "isSent": false, "time": "3:00pm", "seen": false},
      {"text": "Hi! How can I assist you?", "isSent": false, "time": "3:01pm", "seen": false},
    ],
    "Shinra": [
      {"text": "How's it going?", "isSent": false, "time": "4:00pm", "seen": false},
      {"text": "All good! What can I do for you?", "isSent": false, "time": "4:02pm", "seen": false},
    ],
    "Tensei": [
      {"text": "Let's meet up.", "isSent": false, "time": "5:00pm", "seen": false},
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
          final lastMessage = conversations[clientName]!.last;
          final int unreadCount = lastMessage["isSent"]
              ? 0
              : conversations[clientName]!
                  .where((msg) => !msg["isSent"] && !msg["seen"]) // Only count unseen received messages
                  .length;

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.black,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text(
              clientName,
              style: TextStyle(fontWeight: unreadCount > 0 ? FontWeight.bold : FontWeight.normal),
            ),
            subtitle: Text(
              lastMessage["text"],
              style: TextStyle(fontWeight: unreadCount > 0 ? FontWeight.bold : FontWeight.normal),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(client["date"]!, style: TextStyle(fontWeight: FontWeight.bold)),
                unreadCount > 0
                    ? CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Text(
                          unreadCount.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      )
                    : Icon(Icons.check, color: lastMessage["seen"] ? const Color(0xFFFEE500) : Colors.grey),
              ],
            ),
            onTap: () {
              setState(() {
                for (var msg in conversations[clientName]!) {
                  if (!msg["isSent"]) {
                    msg["seen"] = true;
                  }
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