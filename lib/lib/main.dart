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
      home: const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.memory, size: 80, color: Color(0xFF00E5FF)),
              SizedBox(height: 20),
              Text('ISA SUPREME', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text('Core system online', style: TextStyle(color: Colors.white54)),
            ],
          ),
        ),
      ),
    );
  }
}
