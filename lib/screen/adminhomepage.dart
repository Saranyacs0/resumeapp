import 'package:flutter/material.dart';
import 'package:resumeapp/widgets/resume_templatepage.dart';

// Main HomePage with bottom navigation
class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int _currentIndex = 0;

  // Screens for different tabs (now including ResumeTemplatePage in Home)
  final List<Widget> _pages = [
    ResumeTemplatePage(), // Replacing empty text with ResumeTemplatePage
    Center(child: Text('Profile Page')),
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
            icon: Icon(Icons.article),
            label: 'Templates',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Users',
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
