import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hacktinder/data/user.dart';
import 'package:hacktinder/widgets/chat.dart';
import 'package:hacktinder/widgets/user_details.dart';

class Swipe extends StatefulWidget {
  const Swipe({super.key});

  @override
  State<Swipe> createState() {
    return _SwipeState();
  }
}

class _SwipeState extends State<Swipe> {
  var userIndex = 0;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final userValues = [];
  Future<List<AppUser>>? userValuesFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userValuesFuture = getUsers();
  }

  Future<List<AppUser>> getUsers() async {
    try {
      final users = await _firestore.collection("Users").get();
      final List<AppUser> usersList = users.docs.map((user) {
        return AppUser(
          email: user.data()['email'],
          name: user.data()['name'],
          age: user.data()['age'],
          major: user.data()['major'],
          labels: user.data()['labels'],
          skills: user.data()['skills'],
          collegeYear: user.data()['collegeYear'],
          university: user.data()['university'],
          description: user.data()['description'],
          expectation: user.data()['expectation'],
        );
      }).toList();
      return usersList;
    } catch (e) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tech Buddy'),
        actions: [
            IconButton(
              icon: const Icon(Icons.chat_rounded), // Replace with your desired icon
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Chat()),);
              },
            ),
          ],
      ),
      body: FutureBuilder<List<AppUser>>(
        future: userValuesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading users'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No users available'),
            );
          }

          final userValues = snapshot.data!;

          return Container(
            margin: const EdgeInsets.all(15),
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                image: AssetImage('assets/images/img${userIndex + 1}.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name: ${userValues[userIndex].name}",
                    style: const TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Major : ${userValues[userIndex].major} | ${userValues[userIndex].collegeYear}",
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Domain : ${userValues[userIndex].labels}",
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              userIndex++;
                            });
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.red,
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: ((ctx) => UserDetails(userData: userValues[userIndex],)),
                          );
                        },
                        child: const Icon(
                          Icons.list,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            userIndex++;
                          });
                        },
                        child: const Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
