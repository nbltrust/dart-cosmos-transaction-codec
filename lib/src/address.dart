library cosmos_codec.address;

import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:alan/wallet/bech32_encoder.dart';
import 'package:pointycastle/export.dart';

Uint8List my_hexdecode(String hexStr) {
  return Uint8List.fromList(hex.decode((hexStr.length.isOdd ? '0' : '') + hexStr));
}

String publicKeyToAddress(String hexX, String hexY, [bech32Hrp = 'cosmos']) {
  final y = BigInt.parse(hexY, radix: 16);
  final compressedKey = (y.isEven ? [2] : [3]) + my_hexdecode(hexX);

  final sha256Digest = SHA256Digest().process(Uint8List.fromList(compressedKey));
  final address = RIPEMD160Digest().process(sha256Digest);

  return Bech32Encoder.encode(bech32Hrp, address);
}
