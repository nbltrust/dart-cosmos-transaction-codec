library cosmos_codec.transaction;

import 'dart:typed_data';

import 'package:quiver/collection.dart';
import 'package:pointycastle/export.dart';
import 'package:cosmos_codec/cosmos_codec.dart';
import 'package:alan/proto/cosmos/tx/v1beta1/export.dart';
import 'package:alan/proto/cosmos/bank/v1beta1/export.dart' as bank;

Map<String, dynamic> MESSAGE_TYPE_MAP = {
  '/cosmos.bank.v1beta1.MsgSend': (List<int> buffer) => bank.MsgSend.fromBuffer(buffer),
};

class CosmosTransaction extends DelegatingMap {
  final delegate = new Map<String, dynamic>();

  CosmosTransaction(String rawHex) {
    this.delegate['rawHex'] = rawHex;

    final tx = Tx.fromBuffer(my_hexdecode(rawHex));

    final messages = tx.body.messages;
    // print(messages.first.typeUrl);
    // print(messages.first.value);
    // print('\n');

    final msgConstructor = MESSAGE_TYPE_MAP[messages.first.typeUrl];
    if (msgConstructor == null) {
      this.delegate['msgType'] = 'Unknown';
      return;
    }

    this.delegate['msgType'] = messages.first.typeUrl;

    final msg = msgConstructor(messages.first.value);
    this.delegate['from'] = msg.fromAddress;
    this.delegate['to'] = msg.toAddress;
    this.delegate['amount'] = msg.amount.first.amount;
    this.delegate['amountDenom'] = msg.amount.first.denom;

    final authInfo = tx.authInfo;
    final fee = authInfo.fee;
    this.delegate['fee'] = fee.amount.first.amount;
    this.delegate['feeDenom'] = fee.amount.first.denom;
    this.delegate['gasLimit'] = fee.gasLimit.toInt();

    this.delegate['nonce'] = authInfo.signerInfos.first.sequence.toInt();
    this.delegate['memo'] = tx.body.memo;
  }

  factory CosmosTransaction.deserialize(String rawHex) {
    CosmosTransaction tx = new CosmosTransaction(rawHex);

    return tx;
  }

  Uint8List hashToSign() {
    return SHA256Digest().process(Uint8List.fromList(my_hexdecode(this.delegate['rawHex'])));
  }
}
