import 'package:flutter/material.dart';
import 'package:hacktinder/data/user.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key, required this.userData});

  final AppUser userData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 25, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipOval(
              child: Image.asset(
                'assets/images/img1.jpg', // Replace with your image URL
                width: 100.0, // Adjust the size as needed
                height: 100.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5,),
          Center(
            child: Text("${userData.name} | ${userData.age}", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
          ),
          Center(
            child: Text(userData.university, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic),),
          ),
          const SizedBox(height: 15,),
          const Text("Skillset", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
          Text(userData.skills),
          const SizedBox(height: 10,),
          const Text("Description", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
          Text(userData.description),
          const SizedBox(height: 10,),
          const Text("Expectation", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
          Text(userData.expectation),
          
        ],
      ),
    );
  }
}