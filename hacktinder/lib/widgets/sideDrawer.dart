import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hacktinder/widgets/chat.dart';
import 'package:hacktinder/widgets/login.dart';
import 'package:hacktinder/widgets/swipe.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String? message;
  String loggedInUser = "standard@gmail.com";

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void dispose() {
    super.dispose();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user.email.toString();
        print(loggedInUser);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/drawer.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            accountName: const Text('Standard Tester'),
            accountEmail: Text(loggedInUser),
          ),
          ListTile(
              leading: const Icon(Icons.swipe),
              title: const Text('Swipe n Match'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Swipe(),
                  ),
                );
              }),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('Chat'),
            onTap: (){
              Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Chat(),
                  ),
                );
            },
          ),
          ListTile(
            leading: const Icon(Icons.connect_without_contact),
            title: const Text('Likes'),
            onTap: (){
              // 
            },
          ),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
          const ListTile(
            leading: Icon(Icons.help),
            title: Text('Help'),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Log Out'),
            onTap: (){
              Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
            },
          ),
          const Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Acada Matchy v1.0'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}