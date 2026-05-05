import 'package:flutter/material.dart';
import 'screen/focus_mode_screen.dart'; // ده المسار بتاع الفايل اللي لسه عاملينه

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // عشان نشيل علامة الديباج المزعجة
      home: FocusModeScreen(), // هنا بننده على الشاشة بتاعتنا
    );
  }
}