import 'package:flutter/material.dart';


class PageTest extends StatefulWidget {
  final String data;
  const PageTest(this.data);

  @override
  State<PageTest> createState() => _PageTestState();
}

class _PageTestState extends State<PageTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Page Dynamic'),
      ),
    );
  }
}

