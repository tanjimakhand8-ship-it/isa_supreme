// lib/main.dart
import 'package:flutter/material.dart';
import 'theme.dart';

void main() => runApp(const IsaApp());

class IsaApp extends StatelessWidget {
  const IsaApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ISA SUPREME',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.memory, size: 80, color: AppTheme.primary),
              const SizedBox(height: 20),
              const Text('ISA SUPREME', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text('Core system ready', style: TextStyle(color: Colors.white54)),
            ],
          ),
        ),
      ),
    );
  }
}
