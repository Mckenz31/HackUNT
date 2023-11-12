import 'package:flutter/material.dart';
import 'package:hacktinder/widgets/profile_creation.dart';
import 'package:hacktinder/widgets/swipe.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends State<Login> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorMessage = '';

  // void _login() {
  //   if (_usernameController.text.isNotEmpty) {
  //     final newUser = _auth.createUserWithEmailAndPassword(email: _usernameController.text, password: _passwordController.text);
  //     // FirebaseAuth.instance.signInWithEmailAndPassword(email: _usernameController.text, password: _passwordController.text);
  //     _navigateToHome(_usernameController.text);
  //   } else {
  //     setState(() {
  //       _errorMessage = 'Invalid username or password';
  //     });
  //   }
  // }

  // void _signup() {
  //   if (_usernameController.text.isNotEmpty) {
  //     FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: _usernameController.text,
  //       password: _passwordController.text
  //     );
  //     _navigateToHome(_usernameController.text);
  //   } else {
  //     setState(() {
  //       _errorMessage = 'Invalid username or password';
  //     });
  //   }
  // }

  void _navigateToHome(String username) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Swipe()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login/Signup Page'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async{
                  final user = await _auth.signInWithEmailAndPassword(email: _usernameController.text, password: _passwordController.text);
                  if(user!=null){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Swipe()));
                  }
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async{
                  if (_usernameController.text.isNotEmpty) {
                    try{
                      final newUser = await _auth.createUserWithEmailAndPassword(
                        email: _usernameController.text,
                        password: _passwordController.text
                      );
                      if(newUser != null){
                        Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProfileCreation(),
                            ),);
                      }
                    }
                    catch (e){
                      //
                    }
                    _navigateToHome(_usernameController.text);
                  } else {
                    setState(() {
                      _errorMessage = 'Invalid username or password';
                    });
                  }
                },
                child: const Text('Signup'),
              ),
              const SizedBox(height: 16.0),
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
