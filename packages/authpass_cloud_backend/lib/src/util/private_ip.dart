import 'dart:io';

// https://github.com/google/dart-neats/blob/master/safe_url_check/lib/src/private_ip.dart
// https://github.com/google/dart-neats/blob/master/safe_url_check/lib/src/unique_local_ip.dart

/// Returns `true` if [ip] is a private IPv4 address as specified in [rfc1918].
///
/// [rfc1918]: https://tools.ietf.org/html/rfc1918
bool isPrivateIpV4(InternetAddress ip) {
  if (ip.type != InternetAddressType.IPv4) {
    return false;
  }
  // Private IP ranges from: https://tools.ietf.org/html/rfc1918
  // 10.0.0.0        -   10.255.255.255
  if (ip.rawAddress[0] == 10) {
    return true;
  }
  // 172.16.0.0      -   172.31.255.255
  if (ip.rawAddress[0] == 172 &&
      ip.rawAddress[1] >= 16 &&
      ip.rawAddress[1] <= 31) {
    return true;
  }
  // 192.168.0.0     -   192.168.255.255
  if (ip.rawAddress[0] == 192 && ip.rawAddress[1] == 168) {
    return true;
  }
  return false;
}

/// Returns `true` if [ip] is a unique local IPv6 address as established
/// in [rfc4193].
///
/// [rfc4193]: https://tools.ietf.org/html/rfc4193
bool isUniqueLocalIpV6(InternetAddress ip) {
  if (ip.type != InternetAddressType.IPv6) {
    return false;
  }
  // FC00::/7
  if ((ip.rawAddress[0] & (0xff << 1)) == 0xfc) {
    return true;
  }
  return false;
}
