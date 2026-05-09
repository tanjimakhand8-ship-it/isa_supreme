import 'package:flutter/material.dart';
import '../theme.dart';
import '../services/ai_service.dart';

class TerminalScreen extends StatefulWidget {
  const TerminalScreen({super.key});

  @override
  State<TerminalScreen> createState() => _TerminalScreenState();
}

class _TerminalScreenState extends State<TerminalScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final AIService _ai = AIService();
  String _output = 'MARCO HYBRID CORE V21.0 INITIALIZED\n'
      'Neural fusion complete. Status: ONLINE.\n'
      'Welcome back, Master Tanzim Akhand Lamim.\n'
      'Standing by.\n';

  void _execute(String cmd) {
    if (cmd.trim().isEmpty) return;
    setState(() => _output += '\n> $cmd');
    _controller.clear();
    _ai.ask(cmd).then((reply) {
      setState(() => _output += '\nIsa: $reply');
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => _scrollController.jumpTo(_scrollController.position.maxScrollExtent));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Colors.black,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Text(
                _output,
                style: const TextStyle(
                  color: Color(0xFF00FF41),
                  fontFamily: 'JetBrains Mono',
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Color(0xFF1A1A1A))),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  style: const TextStyle(color: Color(0xFF00FF41)),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter command...',
                  ),
                  onSubmitted: _execute,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Color(0xFF00FF41)),
                onPressed: () => _execute(_controller.text),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
