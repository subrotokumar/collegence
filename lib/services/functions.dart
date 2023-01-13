import 'package:collegence/services/constants.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

Future<DeployedContract> loadContract() async {
  String abi = await rootBundle.loadString('assets/abi.json');
  DeployedContract contract = DeployedContract(
      ContractAbi.fromJson(abi, 'Election'),
      EthereumAddress.fromHex(contractAddress));
  return contract;
}

Future<String> callFunction(String functionName, List<dynamic> args,
    Web3Client web3client, String privateKey) async {
  EthPrivateKey cred = EthPrivateKey.fromHex(privateKey);
  DeployedContract contract = await loadContract();
  final ethFunction = contract.function(functionName);
  final result = await web3client.sendTransaction(
    cred,
    Transaction.callContract(
        contract: contract, function: ethFunction, parameters: args),
    chainId: 80001,
    fetchChainIdFromNetworkId: false,
  );
  return result;
}

Future<String> createProposal(Web3Client web3Client) async {
  var response = await callFunction('createProposal',
      ["prop1", EthereumAddress.fromHex(getPublicKey)], web3Client, privateKey);
  print('Election started successfully');
  final e1 = await loadContract();
  final e2 = e1.event('proposalCreated');
  FilterOptions op = FilterOptions(
      address: e1.address,
      fromBlock: BlockNum.genesis(),
      toBlock: BlockNum.current(),
      topics: [
        [bytesToHex(e2.signature, padToEvenLength: true, include0x: true)]
      ]);
  var event = web3Client.events(op);
  event.listen((event) {
    print('dome');
    print(event.toString());
  });
  print(response);
  return response;
}

Future<String> getProposalCount(Web3Client web3Client) async {
  List<dynamic> result = await read('getProposalCount', [], web3Client);
  return result[0].toString();
}

Future<String> getOngoingProposalCount(Web3Client web3Client) async {
  List<dynamic> result = await read('getOngoingProposalCount', [], web3Client);
  return result[0].toString();
}

Future<String> getProposalPassedCount(Web3Client web3Client) async {
  List<dynamic> result = await read('getProposalPassedCount', [], web3Client);
  return result[0].toString();
}

Future<double> getPassRate(Web3Client web3Client) async {
  double a = int.parse(await getProposalPassedCount(web3Client)) * 1.0;
  int b = int.parse(await getProposalCount(web3Client));
  if (b == 0) return 0.5;
  return a / b;
}

Future<String> owner(Web3Client web3Client) async {
  List<dynamic> result = await read('owner', [], web3Client);
  return result[0].toString();
}

Future<String> getMemberCount(Web3Client web3Client) async {
  List<dynamic> result = await read('getMemberCount', [], web3Client);
  return result[0].toString();
}

Future<List> getProposalCount1(Web3Client web3Client) async {
  List<dynamic> result = await read('getProposalCount', [], web3Client);
  return result[0];
}

Future<List> Proposals(Web3Client web3Client, int n) async {
  List<dynamic> result = await read('Proposals', [BigInt.from(n)], web3Client);
  return result;
}

Future<List<dynamic>> read(
    String funcName, List<dynamic> args, Web3Client web3Client) async {
  final contract = await loadContract();
  final ethFunction = contract.function(funcName);
  final result =
      web3Client.call(contract: contract, function: ethFunction, params: args);
  return result;
}

String get getPublicKey => EthPrivateKey.fromHex(privateKey).address.toString();

Future<double> getBalanceInEther(Web3Client web3Client) async {
  var balance1 =
      await web3Client.getBalance(EthereumAddress.fromHex(getPublicKey));
  double balance = balance1.getInWei.toDouble() / (10e17);
  return balance;
}
