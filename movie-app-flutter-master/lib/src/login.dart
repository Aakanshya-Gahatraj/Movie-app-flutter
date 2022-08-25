import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/src/register.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String _email, _password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(title: Text('Login'),),
      // backgroundColor: const Color.fromARGB(255, 4, 4, 4),
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
            const SizedBox(height: 80),
            Center(
              child: Container(
                height: 45,
                width: 400,
                child: Image.asset("assets/Logo.png", fit: BoxFit.fitHeight),
              ),
            ),
            // const Text(" The Movies ",
            // style: TextStyle(fontSize: 50,color: Colors.red, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 60.0, 30.0, 20.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: 'Email',
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
              padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 60.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password",
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
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              ElevatedButton(
                  // color: Theme.of(context).accentColor,
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(100, 50),
                    primary: const Color.fromARGB(255, 226, 92, 77),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16), // <-- Radius
                    ),
                  ),
                  onPressed: () {
                    auth
                        .signInWithEmailAndPassword(
                            email: _email, password: _password)
                        .then((_) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const HomeScreen()));
                    });
                  },
                  child: const Text('Signin')),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 226, 92, 77),
                  fixedSize: const Size(100, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // <-- Radius
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const Register()));
                },
                child: const Text('Signup'),
              )
            ]),

            const SizedBox(height: 80),
            Container(
              height: 265,
              width: 400,
              padding: const EdgeInsets.only(left: 10.0),
              child: Image.asset(
                "assets/sofa-image.png",
                fit: BoxFit.fitHeight,
              ),
            ),

            // SizedBox(height:5),
          ],
        ),
      ),
    );
  }
}
