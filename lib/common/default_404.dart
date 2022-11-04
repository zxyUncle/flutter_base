import 'package:flutter/material.dart';

class Default404 extends StatefulWidget {
  const Default404({Key? key}) : super(key: key);

  @override
  _Default404State createState() => _Default404State();
}

class _Default404State extends State<Default404> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("404"),
      ),
      body: const Center(
        child: Text("404页面"),
      ),
    );
  }
}
