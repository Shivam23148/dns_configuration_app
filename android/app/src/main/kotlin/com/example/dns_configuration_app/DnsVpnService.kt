package com.example.dns_configurator

import android.content.Intent
import android.net.VpnService
import java.net.InetAddress
import java.nio.ByteBuffer

class DnsVpnService : VpnService() {
    private var thread: Thread? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val dnsAddress = intent?.getStringExtra("dnsAddress") ?: "8.8.8.8" // Default to Google DNS
        startVpn(dnsAddress)
        return START_STICKY
    }

    private fun startVpn(dnsAddress: String) {
        thread?.interrupt()
        thread = Thread {
            val builder = Builder()
            builder.setSession("DnsConfigurator")
            builder.addAddress("10.0.0.2", 32) // Virtual VPN address
            builder.addDnsServer(dnsAddress)
            builder.addRoute("0.0.0.0", 0)
            builder.establish()?.use { vpnInterface ->
                val packet = ByteBuffer.allocate(32767)
                while (true) {
                    Thread.sleep(1000) // Keep VPN service alive
                }
            }
        }
        thread?.start()
    }

    override fun onDestroy() {
        thread?.interrupt()
        super.onDestroy()
    }
}