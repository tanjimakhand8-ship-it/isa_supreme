import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import 'terminal.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  String _active = 'Terminal';

  final Map<String, Widget> screens = {
    'Terminal': const TerminalScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(
            active: _active,
            onTap: (module) => setState(() => _active = module),
          ),
          Expanded(child: screens[_active]!),
        ],
      ),
    );
  }
}
