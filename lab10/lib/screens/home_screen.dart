import 'package:flutter/material.dart';

import '../services/storage_service.dart';
import 'login_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> logout(
      BuildContext context) async {

    await StorageService()
        .logout();

    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
        const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
        const Text("Lab 10 Home"),
      ),

      body: Padding(

        padding:
        const EdgeInsets.all(20),

        child: Column(

          children: [

            Card(

              elevation: 5,

              child: ListTile(

                leading:
                const CircleAvatar(
                  child: Icon(
                    Icons.person,
                  ),
                ),

                title: const Text(
                  "Welcome User",
                ),

                subtitle:
                const Text(
                  "Authentication Success",
                ),
              ),
            ),

            const SizedBox(
                height: 20),

            SizedBox(

              width:
              double.infinity,

              child:
              ElevatedButton.icon(

                icon: const Icon(
                  Icons.account_circle,
                ),

                label: const Text(
                  "Google Profile",
                ),

                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                      const ProfileScreen(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(
                height: 15),

            SizedBox(

              width:
              double.infinity,

              child:
              ElevatedButton.icon(

                icon:
                const Icon(Icons.logout),

                label:
                const Text("Logout"),

                onPressed: () =>
                    logout(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}