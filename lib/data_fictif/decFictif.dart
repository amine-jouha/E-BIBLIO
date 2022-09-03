import 'package:ebiblio/exten.dart';
import 'package:flutter/material.dart';

class DecFictif {
  final String title;
  final String type;
  final String name;
  final String exchange;
  final String imageProfil;
  final String imageBook;


  DecFictif({
    required this.title,
    required this.type,
    required this.name,
    required this.exchange,
    required this.imageProfil,
    required this.imageBook

  });
}

List<DecFictif> onDecFictif = [
  DecFictif(type: 'Self-Help', title: 'The Last Night', name: 'Jean-Luc Reichman', imageProfil: 'assets/avatar5.jpg', exchange: '24 exchange', imageBook: 'assets/dec.jpg',),
  DecFictif(type: 'Self-Help', title: 'Self Life', name: 'Milon Henden', imageProfil: 'assets/avatar3.png', exchange: '10 exchange', imageBook: 'assets/dec1.jpg'),
  DecFictif(type: 'Self-Help', title: 'Versus Reality', name: 'Jordi alif', imageProfil: 'assets/avatar5.jpg', exchange: '4 exchange', imageBook: 'assets/dec2.jpg'),
  DecFictif(type: 'Self-Help', title: 'Versus Reality', name: 'Jordi alif', imageProfil: 'assets/avatar5.jpg', exchange: '4 exchange', imageBook: 'assets/dec3.jpg'),
  DecFictif(type: 'Self-Help', title: 'Spider-Monkey', name: 'Moun liod', imageProfil: 'assets/avatar3.png', exchange: '2 exchange', imageBook: 'assets/dec4.jpg'),
  DecFictif(type: 'Self-Help', title: 'Your Self', name: 'Fakif Judh', imageProfil: 'assets/avatar5.jpg', exchange: '0 exchange', imageBook: 'assets/dec5.jpg'),
  DecFictif(type: 'Biographies', title: 'Kilar bee', name: 'Notey Kidh', imageProfil: 'assets/avatar5.jpg', exchange: '12 exchange', imageBook: 'assets/dec6.jpg'),
  DecFictif(type: 'Romance', title: 'Two Of Us', name: 'Lodf jzfh', imageProfil: 'assets/avatar5.jpg', exchange: '15 exchange', imageBook: 'assets/dec7.jpg'),
  DecFictif(type: 'Horror', title: 'Open Door', name: 'Daof Nibar', imageProfil: 'assets/avatar5.jpg', exchange: '22 exchange', imageBook: 'assets/dec8.jpg'),
  DecFictif(type: 'Horror', title: 'Dark Side', name: 'Lokfh ajnfb', imageProfil: 'assets/avatar5.jpg', exchange: '33 exchange', imageBook: 'assets/dec.jpg'),
  DecFictif(type: 'Romance', title: 'Life Matter', name: 'Webdh Lidh', imageProfil: 'assets/avatar5.jpg', exchange: '21 exchange', imageBook: 'assets/dec2.jpg'),
  DecFictif(type: 'Historical', title: 'we are in 1925', name: 'Moufa Nuhf', imageProfil: 'assets/avatar5.jpg', exchange: '10 exchange', imageBook: 'assets/dec4.jpg'),
  DecFictif(type: 'Self-Help', title: 'Solo Ride', name: 'Melonch Kidh', imageProfil: 'assets/avatar5.jpg', exchange: '2 exchange', imageBook: 'assets/dec5.jpg'),



];