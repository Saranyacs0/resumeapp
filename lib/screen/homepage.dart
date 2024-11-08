import 'package:flutter/material.dart';
import 'package:resumeapp/screen/profilepage.dart';
import 'package:resumeapp/widgets/display_templatespage.dart';
import 'package:resumeapp/widgets/resume_templatepage.dart';

// Main HomePage with bottom navigation
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // Screens for different tabs (now including ResumeTemplatePage in Home)
  final List<Widget> _pages = [
    DisplayTemplatespage(),
    ProfilePage(),
    Center(child: Text('Settings Page')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ResumePro',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 197, 41, 224),
        centerTitle: true,
      ),
      body: _pages[_currentIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Active tab index
        onTap: (int index) {
          setState(() {
            _currentIndex = index; // Change the selected tab
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Colors.purple, // Active tab color
        unselectedItemColor: Colors.black, // Inactive tab color
      ),
    );
  }
}

// Resume Template Page to choose a template
