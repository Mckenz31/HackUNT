import 'package:flutter/material.dart';
import 'package:hacktinder/data/user.dart';

class Swipe extends StatefulWidget {
  const Swipe({super.key});

  @override
  State<Swipe> createState() {
    return _SwipeState();
  }
}

class _SwipeState extends State<Swipe> {
  var userIndex = 0;
  final temp_data = [
    User(id: 1, name: "Shane Watzon", image: "img1", major: "Computer Science", studentType: Category.junior, skillset: ["Flutter, React, Django"]),
    User(id: 2, name: "Bruce Rilan", image: "img2", major: "Information Systems", studentType: Category.senior, skillset: ["C, C++, Node.js, Firebase"])
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: const Text('Tech Buddy'),
        ),
      body: Container(
        margin: const EdgeInsets.all(15),
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image:  DecorationImage(
                  image: AssetImage('assets/images/${temp_data[userIndex].image}.jpg'), // replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name: ${temp_data[userIndex].name}", style: const TextStyle(color: Colors.white, fontSize: 25),),
                    const SizedBox(height: 5,),
                    Text("Major : ${temp_data[userIndex].major} | ${temp_data[0].studentType.name}", style: const TextStyle(color: Colors.white, fontSize: 15),),
                    const SizedBox(height: 5,),
                    Text("Skillset : ${temp_data[userIndex].skillset.join(', ')}", style: const TextStyle(color: Colors.white, fontSize: 15),),
                    const SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(onPressed: (){
                          setState(() {
                            userIndex ++;
                          });
                        }, child: const Icon(Icons.close, color: Colors.red,)),
                        const SizedBox(width: 20,),
                        ElevatedButton(onPressed: (){
                          setState(() {
                            userIndex++;
                          });
                        }, child: const Icon(Icons.check, color: Colors.green,))
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
