import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String? loggedInUser;

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextField = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(
    color: Colors.black,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() {
    return _ChatState();
  }
}

class _ChatState extends State<Chat> {
  final txtController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String? message;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    txtController.dispose();
    super.dispose();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user.email;
        print(loggedInUser);
      }
    } catch (e) {
      print(e);
    }
  }

  // getMessage() async{
  //   await for (var snap in _firestore.collection('messages').snapshots()){
  //     for(var message in snap.docs){
  //       print(message.data);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hack Buddy"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // TextStream(firestore: _firestore),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection("messages").orderBy('timestamp').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Messages> messageWidgets = [];
                  snapshot.data!.docs.forEach((element) {
                    var text = element['text'];
                    var sender = element['sender'];
                    final messageWidget = Messages(sender: sender, text: text);
                    messageWidgets.add(messageWidget);
                  });
                  return Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      children: messageWidgets,
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: txtController,
                      onChanged: (value) {
                        message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      txtController.clear();
                      _firestore.collection('messages').add({
                        'text': message,
                        'sender': loggedInUser,
                        'timestamp': FieldValue.serverTimestamp(),
                      });
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Messages extends StatelessWidget {
  Messages({super.key, required this.sender, required this.text});

  final String sender;
  final String text;
  var isMe = false;

  @override
  Widget build(BuildContext context) {
    if(sender == loggedInUser){
      isMe = true;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end: CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: const TextStyle(fontSize: 10.0, color: Colors.black),
          ),
          Material(
            color: isMe ? Colors.orangeAccent : Colors.white,
            elevation: 5,
            borderRadius: isMe ? const BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)) : 
                const BorderRadius.only(
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(color: isMe ? Colors.white : Colors.black54, fontSize: 15.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
