import'package:flutter/material.dart';

class BookShop extends StatefulWidget {
  const BookShop({Key? key}) : super(key: key);

  @override
  State<BookShop> createState() => _BookShopState();
}

class _BookShopState extends State<BookShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Book To Shop'),
        centerTitle: true,
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}


