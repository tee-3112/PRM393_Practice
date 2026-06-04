import 'package:flutter/material.dart';

class Ex1 extends StatelessWidget {
  const Ex1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercise 1 - Core Widgets"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Flutter UI Fundamentals",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Icon(
              Icons.favorite,
              color: Colors.red,
              size: 60,
            ),

            const SizedBox(height: 20),

            Image.network(
              "https://picsum.photos/300/200",
              height: 200,
            ),

            const SizedBox(height: 20),

            Card(
              elevation: 5,
              child: ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Nguyen Son Tung"),
                subtitle: const Text("Flutter Student"),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          ],
        ),
      ),
    );
  }
}