import 'package:flutter/material.dart';

class EditResumePage extends StatefulWidget {
  final String template;

  EditResumePage({required this.template});

  @override
  _EditResumePageState createState() => _EditResumePageState();
}

class _EditResumePageState extends State<EditResumePage> {
  // Controllers for text input
  final TextEditingController nameController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers when the widget is removed from the tree
    nameController.dispose();
    titleController.dispose();
    experienceController.dispose();
    educationController.dispose();
    skillsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Resume'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            // Display selected template image
            Image.asset(widget.template, height:150, fit: BoxFit.cover),
            SizedBox(height: 20),
            
            // Form fields for editing resume details
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Professional Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            
            TextField(
              controller: experienceController,
              decoration: InputDecoration(
                labelText: 'Work Experience',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            
            TextField(
              controller: educationController,
              decoration: InputDecoration(
                labelText: 'Education',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            SizedBox(height: 20),
            
            TextField(
              controller: skillsController,
              decoration: InputDecoration(
                labelText: 'Skills',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            SizedBox(height: 30),
            
            // Save Button
            ElevatedButton(
              onPressed: () {
                // Perform save action, such as saving the resume details
                _saveResume();
              },
              child: Text('Save Resume'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveResume() {
    // Placeholder function to save resume data
    String name = nameController.text;
    String title = titleController.text;
    String experience = experienceController.text;
    String education = educationController.text;
    String skills = skillsController.text;

    // You can process and save this data as needed, e.g., save to a database or file
    print("Name: $name");
    print("Title: $title");
    print("Experience: $experience");
    print("Education: $education");
    print("Skills: $skills");

    // Show a confirmation dialog or snackbar
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Resume saved successfully!"),
    ));
  }
}
