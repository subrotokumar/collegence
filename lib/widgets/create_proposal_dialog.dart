import 'package:collegence/services/functions.dart';
import 'package:flutter/material.dart';

class CreateProposalDialog extends StatefulWidget {
  const CreateProposalDialog({super.key});

  @override
  State<CreateProposalDialog> createState() => _CreateProposalDialogState();
}

class _CreateProposalDialogState extends State<CreateProposalDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      ' Create Proposal',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blueGrey,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: const Text('SUBMIT'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  ' Description',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  maxLength: 50,
                  minLines: 4,
                  maxLines: 12,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  ' List of eligible voter address',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  minLines: 8,
                  maxLines: 1000,
                  decoration: InputDecoration(
                    hintText:
                        '0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266\n0x70997970C51812dc3A010C7d01b50e0d17dc79C8',
                    hintStyle: TextStyle(fontSize: 13),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
          Spacer(),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: Expanded(
              child: ElevatedButton(
                child: Text('Submit'),
                onPressed: () async {},
              ),
            ),
          )
        ],
      ),
    );
  }
}
