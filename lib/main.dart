import 'package:flutter/material.dart';
import 'screens/schedule_screen.dart'; 
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Schedule App',
      theme: ThemeData(
        useMaterial3: true,
        // 
        brightness: Brightness.light,
      ),
      home: ScheduleScreen(), 
    );
  }
}