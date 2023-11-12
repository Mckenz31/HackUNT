import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hacktinder/widgets/swipe.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

enum CollegeYear { freshman, sophomore, junior, senior, graduate }

class ProfileCreation extends StatefulWidget {
  const ProfileCreation({super.key});

  @override
  State<ProfileCreation> createState() {
    return _ProfileCreationState();
  }
}

class _ProfileCreationState extends State<ProfileCreation> {

  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  final _firestore = FirebaseFirestore.instance;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try{
      final user = await _auth.currentUser;
      if(user != null){
        loggedInUser = user;
      }
    }
    catch(e){
      //
    }
  }

  final name = TextEditingController();
  final age = TextEditingController();
  final university = TextEditingController();
  final major = TextEditingController();
  CollegeYear collegeYear = CollegeYear.freshman;
  final labels = TextEditingController();
  final skills = TextEditingController();
  final description = TextEditingController();
  final expectation = TextEditingController();

  String imageUpload = "Upload Image";

  void onSubmit(){
    final doubleAmount = double.tryParse(age.text);
    if(name.text.trim().isEmpty || doubleAmount == null || university.text.trim().isEmpty || description.text.trim().isEmpty
    || major.text.trim().isEmpty || labels.text.trim().isEmpty || skills.text.trim().isEmpty ||
    description.text.trim().isEmpty || expectation.text.trim().isEmpty ){
      showDialog(context: context, builder: (ctx) => AlertDialog(
        title: const Text('Invalid information'),
        content: const Text('Kindly valid information in all the fields'),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(ctx);
          }, child: const Text('Close'))
        ],
      ));
      return;
    }
    _firestore.collection("Users").add({
      'email': loggedInUser.email,
      'name': name.text,
      'age': age.text,
      'university': university.text, 
      'major': major.text,
      'collegeYear': collegeYear.name,
      'labels': labels.text,
      'skills': skills.text,
      'description': description.text, 
      'expectation': expectation.text
    });    
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Swipe()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Acada Matchy"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: name,
                      maxLength: 35,
                      decoration: const InputDecoration(
                        label: Text("Name"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: age,
                      maxLength: 2,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text("Age"),
                      ),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: university,
                maxLength: 45,
                decoration: const InputDecoration(
                  label: Text("University"),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: major,
                      maxLength: 35,
                      decoration: const InputDecoration(
                        label: Text("Major"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownButton(
                        value: collegeYear,
                        items: CollegeYear.values
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.name.toString()),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            collegeYear = value;
                          });
                        }),
                  ),
                ],
              ),
              TextField(
                controller: labels,
                maxLength: 30,
                decoration: const InputDecoration(
                    label: Text("Labels"), hintText: "App developer"),
              ),
              TextField(
                controller: skills,
                maxLength: 50,
                decoration:
                    const InputDecoration(label: Text("Skills"), hintText: "Flutter"),
              ),
              TextField(
                controller: description,
                maxLines: 5,
                decoration: const InputDecoration(
                  label: Text("Description"),
                ),
              ),
              TextField(
                controller: expectation,
                maxLines: 5,
                decoration: const InputDecoration(
                  label: Text("What are you expecting?"),
                ),
              ),
              const SizedBox(height: 15,),
              ElevatedButton.icon(onPressed: () async{
                try {
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['jpg', 'jpeg', 'png'],
                  );
                  if (result != null) {
                    String? filePath = result.files.single.path;
                    setState(() {
                      imageUpload = "Uploaded";
                    });
                  } else {
                    // 
                  }
                } catch (e) {
                  //
                }
              }, icon: const Icon(Icons.upload), label: Text(imageUpload),),
              const SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                onSubmit();
              }, child: const Text("Submit"))          
            ],
          ),
        ),
      ),
    );
  }
}
