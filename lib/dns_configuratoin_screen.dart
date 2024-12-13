import 'package:flutter/material.dart';
import 'package:dns_configuration_app/dns_configurator.dart';
import 'package:dns_configuration_app/dns_history_manager.dart';
import 'package:dns_configuration_app/dns_history_screen.dart';

class DNSConfigScreen extends StatefulWidget {
  @override
  _DNSConfigScreenState createState() => _DNSConfigScreenState();
}

class _DNSConfigScreenState extends State<DNSConfigScreen> {
  late DnsConfigurator dnsConfigurator;
  final String dnsRegex =
      r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$';
  final TextEditingController dnsController = TextEditingController();
  final DnsHistoryManager _dnsHistoryManager = DnsHistoryManager();

  @override
  void initState() {
    super.initState();
    dnsConfigurator = getDnsConfigurator();
  }

  Future<void> _configureDns(String dnsAddress) async {
    if (dnsAddress.isNotEmpty && RegExp(dnsRegex).hasMatch(dnsAddress)) {
      await _dnsHistoryManager.saveDnsAddress(dnsAddress);
      dnsController.clear();
      print("DNS Address Saved: $dnsAddress");
    } else {
      print("Invalid DNS Address: $dnsAddress");
    }
  }

  Future<void> _resetDns() async {
    try {
      await dnsConfigurator.resetDns();
      print("DNS Reset");
    } catch (e) {
      print("Error resetting DNS: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DNS Configurator"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DnsHistoryScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: dnsController,
              decoration: InputDecoration(
                labelText: "Enter DNS Address",
                hintText: "e.g., 8.8.8.8",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (value) {
                _configureDns(value);
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String dnsAddress = dnsController.text;
                RegExp regex = RegExp(dnsRegex);

                if (regex.hasMatch(dnsAddress)) {
                  _configureDns(dnsAddress);
                } else {
                  print("Invalid DNS Address");
                }
              },
              child: Text("Validate and Save DNS"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetDns,
              child: Text("Reset DNS"),
            ),
          ],
        ),
      ),
    );
  }
}
