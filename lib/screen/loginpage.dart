import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resumeapp/screen/homepage.dart';
import 'package:resumeapp/screen/registerpage.dart';
import 'package:resumeapp/screen/adminhomepage.dart'; // Import the AdminHomePage
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  CollectionReference loginUser = FirebaseFirestore.instance.collection('loginUser');

  Future<void> loginUsers() async {
    if (usernameController.text == 'admin') {
      // If username is admin, navigate to AdminHomePage
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Admin login successful!')),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return AdminHomePage();
      }));
    } else {
      // Proceed with the normal login flow for regular users
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: usernameController.text)
          .where('password', isEqualTo: passwordController.text)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String userid = querySnapshot.docs.first.id;
        List<dynamic> resume = querySnapshot.docs.first['resumes'];
        List<String> resumes = List<String>.from(resume);

        // Fetching the email from the user document
        String email = querySnapshot.docs.first['email']; 
        String password = querySnapshot.docs.first['password']; // Assuming email is stored in the 'email' field


        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful!')),
        );

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userid', userid);
        await prefs.setStringList('items', resumes);
        await prefs.setString('username', usernameController.text);
        await prefs.setString('email', email); // Storing the email in SharedPreferences
        await prefs.setString('password', password);

        // Navigate based on the role
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomePage(); // Navigate to HomePage for regular users
        }));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid username or password.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30),
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 197, 41, 224),
            Colors.purpleAccent
          ]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Welcome Back",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 70),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(245, 100, 250, 0.6),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              // Username field
                              TextField(
                                controller: usernameController,
                                decoration: const InputDecoration(
                                  hintText: "UserName",
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(15),
                                ),
                              ),
                              const SizedBox(height: 10),
                              // Password field
                              TextField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: "Password",
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(15),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: loginUsers,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 10,
                            ),
                            backgroundColor: const Color.fromARGB(255, 197, 41, 224),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text("___or___"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return const RegistrationPage();
                                }));
                              },
                              child: const Text(
                                "Register",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 197, 41, 224),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
