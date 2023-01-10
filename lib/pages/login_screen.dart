import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_transition/page_transition.dart';

import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset('assets/images/login.png'),
                const Text(
                  'Collegence DAO',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.blue,
                  ),
                )
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: TextField(
                    onChanged: (value) => setState(() {}),
                    controller: controller,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Private Key',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Your private key stored securely on your device',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20),
                CircleAvatar(
                  backgroundColor: controller.text.isEmpty ? Colors.grey : null,
                  radius: 30,
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                              child: const HomeScreen(),
                              type: PageTransitionType.rightToLeft,
                              duration: const Duration(
                                milliseconds: 1000,
                              ),
                            ),
                          );
                        }
                      },
                      icon: Icon(
                        Icons.arrow_forward_rounded,
                        size: 30,
                        color: controller.text.isEmpty ? Colors.white : null,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
