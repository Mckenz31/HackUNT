import "package:flutter/material.dart";
import "package:hacktinder/widgets/swipe.dart";

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 203, 63, 228),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 221, 147, 236)
);

void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark()
          .copyWith(useMaterial3: true, colorScheme: kDarkColorScheme),
      theme:
          ThemeData().copyWith(useMaterial3: true, colorScheme: kColorScheme),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tech Buddy'),
        ),
        body: const Swipe(),
      ),
    ),
  );
}
