import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Auth Demo"),
      ),
      body: Center(
        child: Text("Auth Success!"),
      ),
    );
  }
}
