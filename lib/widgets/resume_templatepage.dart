import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:resumeapp/screen/addtemplates.dart';
import 'package:resumeapp/screen/editresumepage.dart';
import 'dart:convert'; // For encoding/decoding JSON

class ResumeTemplatePage extends StatefulWidget {
  @override
  _ResumeTemplatePageState createState() => _ResumeTemplatePageState();
}

class _ResumeTemplatePageState extends State<ResumeTemplatePage> {
  List<String> templates = [];

  @override
  void initState() {
    super.initState();
    _loadTemplates(); // Load saved templates when the app starts
  }

  // Load templates from SharedPreferences
  Future<void> _loadTemplates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? templateList = prefs.getString('templates');
    if (templateList != null) {
      setState(() {
        templates = List<String>.from(jsonDecode(templateList));
      });
    }
  }

  // Save templates to SharedPreferences
  Future<void> _saveTemplates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('templates', jsonEncode(templates));
  }

  void _addNewTemplate(String templatePath) {
    setState(() {
      templates.add(templatePath); // Add new template to the list
    });
    _saveTemplates(); // Save updated template list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Adjust according to your design
                    childAspectRatio: 0.7,
                  ),
                  itemCount: templates.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                      },
                      child: Card(
                        elevation: 5,
                        child: Image.asset(templates[index], fit: BoxFit.cover),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            right: 30,
            bottom: 30,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navigate to the AddTemplatePage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddTemplatePage(
                        onTemplateAdded: _addNewTemplate,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.add, color: Colors.white), // Add icon
                label: const Text(''),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 197, 41, 224),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
