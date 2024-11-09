// Flutter app (main.dart)
import 'package:flutter/material.dart';
import 'dart:html' as html;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String messageFromReact = '';

  @override
  void initState() {
    super.initState();
    // Listen for messages from React
    html.window.onMessage.listen((event) {
      if (event.data != null) {
        setState(() {
          messageFromReact = event.data.toString();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Message from React: $messageFromReact'),
              ElevatedButton(
                onPressed: () {
                  // Send message back to React
                  html.window.parent?.postMessage('Hello from Flutter!', '*');
                },
                child: const Text('Send Message to React'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
