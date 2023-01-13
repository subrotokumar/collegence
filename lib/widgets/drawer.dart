import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.purpleAccent.withOpacity(0.5),
            Colors.blue.withOpacity(0.5),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.red,
                ),
                Text(
                  'subrotokumar.eth',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          ListTile(
            title: Text('DASHBOARD'),
            onTap: () {},
          ),
          ListTile(
            title: Text('FAQ'),
            onTap: () {},
          ),
          ListTile(
            title: Text('FORUM'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
