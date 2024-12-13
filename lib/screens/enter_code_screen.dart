import 'package:flutter/material.dart';
import 'package:final_project/utils/http_helper.dart';
import 'package:final_project/screens/movie_selection_screen.dart';

class EnterCodeScreen extends StatefulWidget {
  const EnterCodeScreen({super.key});

  @override
  _EnterCodeScreenState createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends State<EnterCodeScreen> {
  final TextEditingController _codeController = TextEditingController();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Code'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                labelText: 'Enter Code',
                border: OutlineInputBorder(),
                errorText: _errorMessage.isNotEmpty ? _errorMessage : null,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitCode,
              child: const Text('Submit Code'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitCode() async {
    final code = _codeController.text;
    if (code.isEmpty) {
      setState(() {
        _errorMessage = 'Code cannot be empty.';
      });
      return;
    }
    try {
      final response = await HttpHelper.joinSession(code); // Assuming an API to join session
      if (response['status'] == 'success') {
        // Navigate to the movie selection screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MovieSelectionScreen()),
        );
      } else {
        setState(() {
          _errorMessage = 'Invalid code. Please try again.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to join session. Please try again later.';
      });
    }
  }
}
