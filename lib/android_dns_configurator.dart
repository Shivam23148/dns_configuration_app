import 'dart:io';
import 'package:dns_configuration_app/dns_configurator.dart';
import 'package:flutter/services.dart';

class AndroidDnsConfigurator implements DnsConfigurator {
  static const platform = MethodChannel("dns_configurator");

  @override
  Future<void> configureDns(String dnsAddress) async {
    if (Platform.isAndroid) {
      try {
        final result = await platform
            .invokeMethod("configureDns", {"dnsAddress": dnsAddress});
        print("DNS configured on Android: $result");
      } catch (e) {
        throw Exception("Failed to configure DNS on Android: $e");
      }
    } else {
      throw UnsupportedError("This class supports Android only.");
    }
  }

  Future<void> resetDns() async {
    if (Platform.isAndroid) {
      try {
        final result = await platform.invokeMethod("resetDns");
        print("DNS reset on Android: $result");
      } catch (e) {
        throw Exception("Failed to reset DNS on Android: $e");
      }
    } else {
      throw UnsupportedError("This class supports Android only.");
    }
  }
}
