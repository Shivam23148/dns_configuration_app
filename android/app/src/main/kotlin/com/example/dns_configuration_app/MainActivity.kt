package com.example.dns_configuration_app.DnsVpnService

import com.example.dns_configuration_app.DnsVpnService
import io.flutter.embedding.android.FlutterActivity
import android.content.Intent
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "dns_configurator"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "startVpn" -> {
                    val dnsAddress = call.argument<String>("dnsAddress")
                    val intent = Intent(this, DnsVpnService::class.java).apply {
                        putExtra("dnsAddress", dnsAddress)
                    }
                    startService(intent)
                    result.success("VPN started with DNS: $dnsAddress")
                }
                "stopVpn" -> {
                    val intent = Intent(this, DnsVpnService::class.java)
                    stopService(intent)
                    result.success("VPN stopped")
                }
                else -> result.notImplemented()
            }
        }
    }
}