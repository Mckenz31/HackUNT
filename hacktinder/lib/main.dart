import "package:flutter/material.dart";
import "package:hacktinder/widgets/chat.dart";
import "package:hacktinder/widgets/login.dart";
import "package:hacktinder/widgets/onboarding.dart";
import "package:hacktinder/widgets/profile_creation.dart";
import "package:hacktinder/widgets/swipe.dart";
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 203, 63, 228),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 221, 147, 236)
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark()
          .copyWith(useMaterial3: true, colorScheme: kDarkColorScheme),
      theme:
          ThemeData().copyWith(useMaterial3: true, colorScheme: kColorScheme),
      debugShowCheckedModeBanner: false,
      home: const Login(),
    ),
  );
}
