import 'package:collegence/services/constants.dart';
import 'package:flutter/services.dart';
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

Future<String> startElection(String name, Web3Client web3Client) async {
  var response = await callFunction('startElection', [name], web3Client, "");
  print('Election started successfully');
  return response;
}

Future<List> getCandidatesNum(Web3Client web3Client) async {
  List<dynamic> result = await read('getNumCandidates', [], web3Client);
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
