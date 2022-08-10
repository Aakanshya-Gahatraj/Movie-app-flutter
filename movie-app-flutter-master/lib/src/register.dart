import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late String _email, _password;
  final auth = FirebaseAuth.instance;
  int cnt = 0;

  // void showMsg() {
  //   print(const Text("User Registered!"));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFF2D2D8B), elevation: 0),
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF2D2D8B),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            height: 60,
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
          const Text("Registration:", 
          style: TextStyle(
            color:Colors.white,
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
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
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
              onChanged: (value) {
                setState(() {
                  _password = value.trim();
                });
              },
            ),
          ),
          Container(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(100, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // <-- Radius
                  ),
                ),
                onPressed: () {
                  auth
                      .createUserWithEmailAndPassword(
                          email: _email, password: _password)
                      .then((_) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()));
                  });
                },
                child: const Text('Register')),
          ),
        ],
      ),
    );
  }
}
