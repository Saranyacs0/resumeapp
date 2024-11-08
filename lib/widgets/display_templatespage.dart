import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:resumeapp/screen/editresumepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplayTemplatespage extends StatefulWidget {
  const DisplayTemplatespage({super.key});

  @override
  State<DisplayTemplatespage> createState() => _DisplayTemplatespageState();
}

class _DisplayTemplatespageState extends State<DisplayTemplatespage> {

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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditResumePage(template: templates[index]),
                          ),
                        );
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
        ],
      ),
    );
  }
}