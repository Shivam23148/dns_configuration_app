import 'dart:io';

import 'package:dns_configuration_app/android_dns_configurator.dart';
import 'package:dns_configuration_app/window_dns_configurator.dart';

abstract class DnsConfigurator {
  Future<void> configureDns(String dnsAddress);
  Future<void> resetDns();
}

DnsConfigurator getDnsConfigurator() {
  if (Platform.isAndroid) {
    return AndroidDnsConfigurator();
  } else if (Platform.isWindows) {
    return WindowDnsConfigurator();
  } else {
    throw UnsupportedError("Unsupported Platform");
  }
}
