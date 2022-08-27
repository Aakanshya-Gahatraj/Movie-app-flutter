import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 31, 7, 55),
              Color.fromARGB(255, 0, 0, 0),
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 25),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back,
                    color: Color.fromARGB(255, 252, 251, 251)),
                onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen())),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 45,
              width: 400,
              child: Image.asset(
                "assets/Logo.png",
                fit: BoxFit.fitHeight,
              ),
            ),
            const SizedBox(height: 50),
            Container(
              height: 200,
              width: 500,
              child: Image.asset(
                "assets/clips.png",
                fit: BoxFit.fitHeight,
              ),
            ),
            const SizedBox(height: 45),
            const Text(
              "Registration:",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 20.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: 'Type in your Email',
                    filled: true,
                    fillColor: const Color(0xffFDF6F6),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
                controller: emailController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 40.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Create a Password",
                    filled: true,
                    fillColor: const Color(0xffFDF6F6),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
                controller: passwordController,
              ),
            ),
            Container(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 226, 92, 77),
                    fixedSize: const Size(100, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16), // <-- Radius
                    ),
                  ),
                  onPressed: () {
                    auth
                        .createUserWithEmailAndPassword(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim())
                        .then((_) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginScreen()));
                    });
                  },
                  child: const Text('Register')),
            ),
          ],
        ),
      ),
    );
  }
}
