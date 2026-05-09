import 'package:flutter/material.dart';
import '../theme.dart';
import '../services/ai_service.dart';

class SovereignAssetsScreen extends StatefulWidget {
  const SovereignAssetsScreen({super.key});

  @override
  State<SovereignAssetsScreen> createState() => _SovereignAssetsScreenState();
}

class _SovereignAssetsScreenState extends State<SovereignAssetsScreen> {
  final AIService _ai = AIService();
  Map<String, dynamic>? _portfolio;

  @override
  void initState() {
    super.initState();
    _fetchPortfolio();
  }

  Future<void> _fetchPortfolio() async {
    final reply = await _ai.ask("portfolio status");
    setState(() {
      _portfolio = {
        'total': 250000,
        'change': 12.4,
        'crypto': 162500,
        'forex': 37500,
        'commerce': 37500,
        'exposure': 12,
        'win_prob': 92,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_portfolio == null) {
      return const Center(child: CircularProgressIndicator());
    }
    final data = _portfolio!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('SOVEREIGN ASSETS',
              style: TextStyle(
                  color: Color(0xFF00FF41),
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          const Text('GLOBAL WEALTH ACCUMULATION & NEURAL PORTFOLIO',
              style: TextStyle(color: Colors.white54, fontSize: 11)),
          const SizedBox(height: 20),
          _buildInfoRow('TOTAL NET WORTH', '\$${data['total']}'),
          _buildInfoRow('Total Realized Profit', '\$0.00'),
          _buildInfoRow('Active Node Exposure', '${data['exposure']} UNITS'),
          _buildInfoRow('+${data['change']}% vs Last Session',
              '\$${data['crypto'] + data['forex'] + data['commerce']}',
              isGreen: true),
          const SizedBox(height: 30),
          const Text('ALLOCATION STRATEGY',
              style: TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 10),
          _buildAllocationBar(
              'CRYPTO NEXUS', data['crypto'] / data['total'], '\$${data['crypto']}', Colors.cyan),
          _buildAllocationBar(
              'FOREX MASTER', data['forex'] / data['total'], '\$${data['forex']}', Colors.green),
          _buildAllocationBar('APEX COMMERCE',
              data['commerce'] / data['total'], '\$${data['commerce']}', Colors.orange),
          const SizedBox(height: 30),
          const Text('GATEWAY NEURAL LINKS',
              style: TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 10),
          _buildGatewayRow('BINANCE', '\$${data['crypto']}', Icons.link),
          _buildGatewayRow('MT5', '\$${data['forex']}', Icons.link),
          _buildGatewayRow('SHOPIFY', '\$${data['commerce']}', Icons.link),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, color: Colors.black),
              label: const Text('CONNECT NEW NODE',
                  style: TextStyle(color: Colors.black)),
              style:
                  ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00FF41)),
            ),
          ),
          const SizedBox(height: 20),
          const Text('RISK PROTOCOL: MASTER_APEX_V2',
              style: TextStyle(color: Colors.white30, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isGreen = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
          Text(value,
              style: TextStyle(
                color: isGreen ? const Color(0xFF00FF41) : Colors.white,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }

  Widget _buildAllocationBar(
      String label, double fraction, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: TextStyle(
                      color: color,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
              Text(value,
                  style: const TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: fraction,
            backgroundColor: Colors.grey[900],
            color: color,
          ),
        ],
      ),
    );
  }

  Widget _buildGatewayRow(String name, String value, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF00FF41), size: 18),
      title: Text(name,
          style: const TextStyle(color: Colors.white70, fontSize: 12)),
      trailing: Text(value,
          style:
              const TextStyle(color: Color(0xFF00FF41), fontSize: 12)),
      dense: true,
      contentPadding: EdgeInsets.zero,
    );
  }
}
