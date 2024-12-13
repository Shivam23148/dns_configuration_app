import 'package:flutter/material.dart';
import 'dns_history_manager.dart';

class DnsHistoryScreen extends StatefulWidget {
  @override
  _DnsHistoryScreenState createState() => _DnsHistoryScreenState();
}

class _DnsHistoryScreenState extends State<DnsHistoryScreen> {
  final DnsHistoryManager _dnsHistoryManager = DnsHistoryManager();
  List<String> _dnsHistory = [];

  @override
  void initState() {
    super.initState();
    _loadDnsHistory();
  }

  // Load the DNS history from local storage
  Future<void> _loadDnsHistory() async {
    List<String> history = await _dnsHistoryManager.getDnsHistory();
    setState(() {
      _dnsHistory = history;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("DNS History")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _dnsHistory.isEmpty
            ? Center(child: Text("No DNS history found"))
            : ListView.builder(
                itemCount: _dnsHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_dnsHistory[index]),
                  );
                },
              ),
      ),
    );
  }
}
