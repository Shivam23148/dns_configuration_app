# DNS Configuration App

This app allows users to configure DNS settings dynamically on Android and Windows platforms. It also stores and displays a history of DNS addresses that have been entered by the user.

## Features:
- **Configure DNS**: Allows users to set a custom DNS address for their device.
- **DNS Validation**: Validates DNS addresses using a regex pattern to ensure correctness.
- **DNS History**: Stores and displays a list of all DNS addresses entered by the user.
- **Platform Support**: Supports Android and Windows devices.

## Platform-Specific Implementation:

### Android
On Android, the app uses the `flutter_vpn` package to set a VPN configuration for DNS modification. However, full system DNS modification requires additional permissions and system-level access that may require rooted devices. For non-rooted devices, this solution works within the bounds of app-level VPN services.

### Windows
For Windows, the app leverages platform channels to modify the system DNS settings. This is done by accessing the Windows network configuration programmatically and updating the DNS servers.

## Setup and Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/your-repository/dns-configuration-app.git
   cd dns-configuration-app
