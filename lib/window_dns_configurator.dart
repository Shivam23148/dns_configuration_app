import 'package:dns_configuration_app/dns_configurator.dart';
import 'package:process_run/process_run.dart';

class WindowDnsConfigurator implements DnsConfigurator {
  @override
  Future<void> configureDns(String dnsAddress) async {
    String interfaceName = "Wi-Fi";

    try {
      await runExecutableArguments('netsh', [
        'interface',
        'ip',
        'set',
        'dns',
        interfaceName,
        'static',
        dnsAddress
      ]);

      print("DNS settings applied successfully.");
    } catch (e) {
      print("Failed to apply DNS settings: $e");
    }
  }

  @override
  Future<void> resetDns() {
    // TODO: implement resetDns
    throw UnimplementedError();
  }
}
