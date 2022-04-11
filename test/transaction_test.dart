library cosmos_codec_test.transaction_test;

import 'package:convert/convert.dart';
import 'package:cosmos_codec/cosmos_codec.dart';
import 'package:test/test.dart';

void main() {
  test("test transaction", () {
    final rawHex =
        '0a9c010a8f010a1c2f636f736d6f732e62616e6b2e763162657461312e4d736753656e64126f0a2d636f736d6f73317073737877647a777a656137757333777264707664726734307634707136717377676d307332122d636f736d6f733168726e6c3570756761673230676e75387a79333630346a657471726a61663630637a6b6c38751a0f0a057561746f6d120631303030303012084e6f756e7536777a12670a500a460a1f2f636f736d6f732e63727970746f2e736563703235366b312e5075624b657912230a2103799ebbf7a6d305c81b0954406f0bca2a6851ba661667d6153a9bf47615f5cdbd12040a020801181812130a0d0a057561746f6d1204323030301080f1041a0c766567612d746573746e657420a0bd17';
    final tx = CosmosTransaction.deserialize(rawHex);

    expect(tx['from'], 'cosmos1pssxwdzwzea7us3wrdpvdrg40v4pq6qswgm0s2');
    expect(tx['to'], 'cosmos1hrnl5pugag20gnu8zy3604jetqrjaf60czkl8u');
    expect(tx['amount'], '100000');
    expect(tx['amountDenom'], 'uatom');
    expect(tx['fee'], '2000');
    expect(tx['feeDenom'], 'uatom');
    expect(tx['gasLimit'], 80000);
    expect(tx['nonce'], 24);
    expect(tx['memo'], 'Nounu6wz');

    expect(hex.encode(tx.hashToSign()), '5b692cc48b1c74fcb4bb59fbacfea6f1c185e5326a00c845b64ccf99aeab0f4a');
  });
}
