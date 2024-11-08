import 'package:flutter/material.dart';
import 'package:resumeapp/widgets/image_pickerpage.dart';
import 'package:resumeapp/widgets/passwordpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = '';
  String email = '';
  String password = '';

  // Function to fetch user details from SharedPreferences
  Future<void> loadUserProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'No username available';
      email = prefs.getString('email') ?? 'No email available';
      password = prefs.getString('password') ?? 'No password available';
    });
  }

  @override
  void initState() {
    super.initState();
    loadUserProfile(); // Load user profile data when page is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImagePickerPage(),
             SizedBox(height: 20),
            // Display Username
            Text(
              '  $username',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            // Display Email
            Text(
              '  $email',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            // Display Password (you could hide part of it for privacy)
            Row(
              children: [
                Text(
                  '  Password: ${'*' * password.length}', // Hide actual password
                  style: const TextStyle(fontSize: 18),
                ),
                SizedBox(width: 170,),
                  TextButton(
                onPressed: () {
                  // Navigate to Forgot Password screen
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ForgotPasswordPage(); // Implement this page
                  }));
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
