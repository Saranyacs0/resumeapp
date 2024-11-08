import 'package:flutter/material.dart';

class AddTemplatePage extends StatefulWidget {
  final Function(String) onTemplateAdded;

  const AddTemplatePage({Key? key, required this.onTemplateAdded}) : super(key: key);

  @override
  _AddTemplatePageState createState() => _AddTemplatePageState();
}

class _AddTemplatePageState extends State<AddTemplatePage> {
  final _templateController = TextEditingController();

  @override
  void dispose() {
    _templateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
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
      body: SingleChildScrollView( // Added to prevent overflow
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Align content horizontally
          children: [
            const SizedBox(height: 200),
            TextField(
              controller: _templateController,
              decoration: const InputDecoration(
                labelText: 'Template Image Path',
                hintText: 'e.g., assets/template1.png',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_templateController.text.isNotEmpty) {
                  widget.onTemplateAdded(_templateController.text);
                  Navigator.pop(context); // Go back to the previous page
                } else {
                  // Show error if the text field is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a template path'),
                    ),
                  );
                }
              },
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
              child: const Text(
                'Add Template',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
