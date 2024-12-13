import 'package:shared_preferences/shared_preferences.dart';

class DnsHistoryManager {
  // Save the DNS address in the history
  Future<void> saveDnsAddress(String dnsAddress) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> dnsHistory = prefs.getStringList('dns_history') ?? [];

    // Limit the history to 10 items
    if (dnsHistory.length >= 10) {
      dnsHistory.removeAt(0);
    }

    dnsHistory.add(dnsAddress);
    await prefs.setStringList('dns_history', dnsHistory);
  }

  // Retrieve DNS history
  Future<List<String>> getDnsHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('dns_history') ?? [];
  }

  // Clear DNS history
  Future<void> clearDnsHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('dns_history');
  }
}
