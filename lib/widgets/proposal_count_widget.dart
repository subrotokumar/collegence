import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:web3dart/web3dart.dart';

import '../services/functions.dart';

class ProposalCountWidget extends StatelessWidget {
  Web3Client web3Client;

  ProposalCountWidget(this.web3Client, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getProposalCount(web3Client),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('');
        }
        return Text(
          snapshot.data!.toString(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.purpleAccent,
          ),
        );
      },
    );
  }
}
