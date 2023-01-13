import 'package:collegence/services/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';

class ConnectWallet extends StatefulWidget {
  Web3Client web3Client;
  ConnectWallet(this.web3Client, {super.key});

  @override
  State<ConnectWallet> createState() => _ConnectWalletState();
}

class _ConnectWalletState extends State<ConnectWallet> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      future: getBalanceInEther(widget.web3Client),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else {
          return InkWell(
            onTap: () => showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    ElevatedButton(onPressed: () {}, child: Text('Disconnect'))
                  ],
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${getPublicKey.substring(0, getPublicKey.length >> 1)}\n${getPublicKey.substring(getPublicKey.length >> 1)}',
                            style:
                                TextStyle(fontSize: 16, color: Colors.indigo),
                          ),
                        ],
                      ),
                      Divider(thickness: 2),
                      Text(
                          'Balance: ${snapshot.data!.toString().substring(0, 10)} MATIC'),
                      Divider(
                        thickness: 1,
                      ),
                      Text('Chain ID : 80001'),
                      Divider(
                        thickness: 1,
                      ),
                      Text('Network : Polygon Mumbai'),
                    ],
                  ),
                );
              },
            ),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                // border: Border.all(color: Colors.blue),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 12,
                    child: Image.asset('assets/images/polygon.png'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: Text(
                      snapshot.data!.toString().substring(0, 5),
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(30),
                      // border: Border.all(color: Colors.blue),
                    ),
                    child: Text(
                      '${getPublicKey.substring(0, 6)}...${getPublicKey.substring(getPublicKey.length - 4)}',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
