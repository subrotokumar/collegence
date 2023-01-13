import 'dart:io';

import 'package:collegence/services/constants.dart';
import 'package:collegence/services/proposal_modal.dart';
import 'package:collegence/widgets/connect_wallet.dart';
import 'package:collegence/widgets/create_proposal_dialog.dart';
import 'package:collegence/widgets/eligible_voters_widget.dart';
import 'package:collegence/widgets/ongoing_proposal_widget.dart';
import 'package:collegence/widgets/proposal_count_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../services/functions.dart';
import '../widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Client httpClient;
  late Web3Client web3Client;

  @override
  void initState() {
    httpClient = Client();
    web3Client = Web3Client(rpcURL, httpClient);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: true,
      drawer: Drawer(
        child: MainDrawer(),
      ),
      body: Container(
        child: RefreshIndicator(
          onRefresh: () {
            setState(() {});
            return Future<void>.delayed(const Duration(milliseconds: 100));
          },
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.purpleAccent,
                      Colors.blue,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                height: 400,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        // IconButton(
                        //   icon: Icon(Icons.menu),
                        //   onPressed: () async {
                        //     print(getPublicKey);
                        //   },
                        //   color: Colors.white,
                        // ),
                        InkWell(
                          onLongPress: () async {
                            setState(() {});
                            await createProposal(web3Client);
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            child: Image.asset(
                              'assets/images/icon.png',
                              width: 36,
                            ),
                          ),
                        ),
                        // const Text(
                        //   ' DAO',
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 23,
                        //   ),
                        // ),
                        Spacer(),
                        ConnectWallet(web3Client),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: const <Widget>[
                        Text(
                          ' Governance Overview',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      color: Colors.white,
                      child: ListTile(
                        title: Row(
                          children: const [
                            Text(
                              'Proposals Created',
                            ),
                            Spacer(),
                            Text(
                              'Pass Rate',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ProposalCountWidget(web3Client),
                            SizedBox(
                              width: 100,
                              child: FutureBuilder<double>(
                                future: getPassRate(web3Client),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return LinearProgressIndicator(
                                      color: Colors.blue,
                                      value: 0.10,
                                    );
                                  }
                                  print(snapshot.data!);
                                  return LinearProgressIndicator(
                                    color: Colors.blue,
                                    value: snapshot.data,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            color: Colors.white,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              height: 50,
                              width: 160,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // ignore: prefer_const_constructors
                                children: [
                                  Text(
                                    'Eligible Voters',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  EligibleVotersCountWidget(web3Client),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            color: Colors.white,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              height: 50,
                              width: 160,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // ignore: prefer_const_constructors
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Text(
                                    'Ongoing Proposals',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  OngoingProposalsWidget(web3Client),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text(
                          ' Recent Proposals',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(
                            Icons.add_comment_rounded,
                            size: 25,
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              constraints: BoxConstraints(maxHeight: 700),
                              isScrollControlled: true,
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              builder: (context) {
                                return CreateProposalDialog();
                              },
                            );
                          },
                          color: Colors.white,
                          iconSize: 18,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 25,
                color: Colors.blue,
                child: Container(
                  height: 25,
                  padding: EdgeInsets.only(top: 25),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'ID',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 12),
                  ),
                  Text(
                    'Description',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 12),
                  ),
                  Text(
                    'Status',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 12),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Divider(),
              Expanded(
                child: FutureBuilder<String>(
                    future: getProposalCount(web3Client),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.purpleAccent,
                          ),
                        );
                      }
                      int num = int.parse(snapshot.data ?? "0");
                      if (snapshot.data.toString() == "0") {
                        return Padding(
                            padding: EdgeInsets.all(20),
                            child: Center(child: Text("No Data")));
                      }
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            for (int index = num;
                                index >= (num <= 10 ? 1 : num - 10);
                                index--)
                              InkWell(
                                onTap: () {},
                                child: FutureBuilder<dynamic>(
                                  future: Proposals(web3Client, index),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      ProposalTile(20);
                                    } else if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      print(snapshot.data!.toString());
                                      ProposalModal data =
                                          ProposalModal.fromList(
                                              snapshot.data!);

                                      MaterialColor c = Colors.blue;
                                      String t = 'Ongoing';
                                      if (data.countConducted) {
                                        if (data.voteUp.toInt() >
                                            data.voteDown.toDouble()) {
                                          c = Colors.green;
                                          t = 'Passed';
                                        } else {
                                          c = Colors.red;
                                          t = 'Rejected';
                                        }
                                      }
                                      return Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                20, 10, 20, 10),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${data.id}',
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                                SizedBox(width: 20),
                                                Expanded(
                                                  child: Text(
                                                    '${data.description}',
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Container(
                                                  width: 80,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color: c.withOpacity(0.1),
                                                  ),
                                                  child: Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: Text(
                                                        t,
                                                        style:
                                                            TextStyle(color: c),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(),
                                        ],
                                      );
                                    }
                                    return ProposalTile(404);
                                  },
                                ),
                              ),
                            // const Divider(),
                          ],
                        ),
                      );
                    }),
              ),
              Divider(),
              SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(onPressed: () {}, child: Text('Prev')),
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        ' ${1} ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    TextButton(onPressed: () {}, child: Text('Next')),
                  ],
                ),
              )
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class ProposalTile extends StatelessWidget {
  int id;
  ProposalTile(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    MaterialColor c = Colors.green;
    String t = 'Passed';
    if (id % 3 == 0) {
      c = Colors.blue;
      t = 'Ongoing';
    }
    if (id % 5 == 0) {
      c = Colors.red;
      t = 'Rejected';
    }
    return ListTile(
      leading: Text(
        '\n$id',
        style: const TextStyle(fontSize: 12),
      ),
      title: const Text(
        'Should we start',
        style: TextStyle(fontSize: 12),
      ),
      trailing: Container(
        width: 80,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: c.withOpacity(0.1),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              t,
              style: TextStyle(color: c),
            ),
          ),
        ),
      ),
    );
  }
}

// class MainProposalTile extends StatelessWidget {
//   String id;
//   MainProposalTile(this.id, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     MaterialColor c = Colors.green;
//     String t = 'Passed';
//     if (id % 3 == 0) {
//       c = Colors.blue;
//       t = 'Ongoing';
//     }
//     if (id % 5 == 0) {
//       c = Colors.red;
//       t = 'Rejected';
//     }
//     return ListTile(
//       leading: Text(
//         '\n$id',
//         style: const TextStyle(fontSize: 12),
//       ),
//       title: const Text(
//         'Should we start',
//         style: TextStyle(fontSize: 12),
//       ),
//       trailing: Container(
//         width: 80,
//         height: 35,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: c.withOpacity(0.1),
//         ),
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               t,
//               style: TextStyle(color: c),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
