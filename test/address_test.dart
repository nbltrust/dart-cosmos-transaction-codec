library cosmos_codec_test.address_test;

import 'package:cosmos_codec/cosmos_codec.dart';
import 'package:test/test.dart';

void main() {
  test("test publicKeyToAddress", () {
    final addr = publicKeyToAddress('86bc02aa63fcdf8ab095121e288597dc5d3e0e0d26b81d8ff0d90e617292bbff',
        '86fd25b7d195095172a16b90655ff3608c360ce522a6b5d5e35ce5dbc61a63dc');

    assert(addr == 'cosmos1vejxser3ugxhlj9s2uyu2n85hkmt0hnhwehv32');
  });
}
