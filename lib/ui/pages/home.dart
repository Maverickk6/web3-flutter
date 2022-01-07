import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String rpcUrl = 'http://127.0.0.1:7545';
  String wsUrl = "ws://127.0.0.1:7545";

  Future<void> sendEther() async {
    Web3Client client = Web3Client(rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });

    String privateKey =
        "3384c2999d76967857a615e1dc964f29a687541ea1e93777dd7e51a996947b59";

    Credentials credentials =
        await client.credentialsFromPrivateKey(privateKey);

    EthereumAddress ownAddress = await credentials.extractAddress();
    EthereumAddress reciever =
        EthereumAddress.fromHex("0x69B9D83819D88315957259a3c3b6654Fded0c29a");
    print(ownAddress);

    client.sendTransaction(
        credentials,
        Transaction(
            from: ownAddress,
            to: reciever,
            value: EtherAmount.fromUnitAndValue(EtherUnit.ether, 10)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Crypto App',
        ),
      ),
      backgroundColor: const Color(0xFF181818),
      body: Stack(children: [
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Click Me',
              ),
              const SizedBox(height: 8),
              CupertinoButton(
                onPressed: sendEther,
                color: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
