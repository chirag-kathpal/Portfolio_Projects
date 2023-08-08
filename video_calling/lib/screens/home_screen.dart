import 'package:flutter/material.dart';
import 'package:video_calling/screens/call_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Container(
        child: ElevatedButton(
          child: const Text(
            'Join Call',
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyCall(callID: '1'),
              ),
            );
          },
        ),
      ),
    );
  }
}
