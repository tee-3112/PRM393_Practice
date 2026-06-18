import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/storage_service.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final _formKey =
  GlobalKey<FormState>();

  final usernameController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  bool isLoading = false;

  Future<void> login() async {

    if (!_formKey.currentState!
        .validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    String? token =
    await AuthService().login(
      usernameController.text,
      passwordController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (token != null) {

      await StorageService()
          .saveToken(token);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
          const HomeScreen(),
        ),
      );

    } else {

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Login Failed",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        decoration:
        const BoxDecoration(

          gradient: LinearGradient(

            colors: [
              Colors.deepPurple,
              Colors.purpleAccent,
            ],

            begin:
            Alignment.topLeft,

            end:
            Alignment.bottomRight,
          ),
        ),

        child: Center(

          child:
          SingleChildScrollView(

            child: Padding(

              padding:
              const EdgeInsets.all(24),

              child: Card(

                elevation: 10,

                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(
                      20),
                ),

                child: Padding(

                  padding:
                  const EdgeInsets.all(
                      24),

                  child: Form(

                    key: _formKey,

                    child: Column(

                      mainAxisSize:
                      MainAxisSize.min,

                      children: [

                        const Icon(
                          Icons.lock,
                          size: 80,
                          color: Colors.deepPurple,
                        ),

                        const SizedBox(
                            height: 20),

                        const Text(
                          "Welcome Back",
                          style:
                          TextStyle(
                            fontSize: 28,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                            height: 10),

                        const Text(
                          "Login using DummyJSON",
                        ),

                        const SizedBox(
                            height: 30),

                        TextFormField(

                          controller:
                          usernameController,

                          decoration:
                          InputDecoration(
                            labelText:
                            "Username",
                            prefixIcon:
                            const Icon(
                              Icons.person,
                            ),
                            border:
                            OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(
                                  15),
                            ),
                          ),

                          validator:
                              (value) {

                            if (value ==
                                null ||
                                value
                                    .isEmpty) {

                              return "Enter username";
                            }

                            return null;
                          },
                        ),

                        const SizedBox(
                            height: 20),

                        TextFormField(

                          controller:
                          passwordController,

                          obscureText:
                          true,

                          decoration:
                          InputDecoration(
                            labelText:
                            "Password",
                            prefixIcon:
                            const Icon(
                              Icons.lock,
                            ),
                            border:
                            OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(
                                  15),
                            ),
                          ),

                          validator:
                              (value) {

                            if (value ==
                                null ||
                                value
                                    .isEmpty) {

                              return "Enter password";
                            }

                            return null;
                          },
                        ),

                        const SizedBox(
                            height: 30),

                        SizedBox(

                          width:
                          double.infinity,

                          height: 55,

                          child: isLoading

                              ? const Center(
                            child:
                            CircularProgressIndicator(),
                          )

                              : ElevatedButton(

                            onPressed:
                            login,

                            style:
                            ElevatedButton.styleFrom(
                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(
                                    15),
                              ),
                            ),

                            child:
                            const Text(
                              "LOGIN",
                            ),
                          ),
                        ),

                        const SizedBox(
                            height: 20),

                        const Text(
                          "Test Account",
                        ),

                        const Text(
                          "Username: emilys",
                        ),

                        const Text(
                          "Password: emilyspass",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}