import 'package:ebiblio/exten.dart';
import 'package:flutter/material.dart';

class Fictif {
  final String title;
  final String type;
  final String name;
  final String exchange;
  final String imageProfil;
  final String imageBook;


  Fictif({
    required this.title,
    required this.type,
    required this.name,
    required this.exchange,
    required this.imageProfil,
    required this.imageBook

  });
}

List<Fictif> onFictif = [
  Fictif(type: 'Self-Help', title: 'The Last Night For Some man', name: 'Jean-Luc Reichman', imageProfil: 'assets/avatar5.jpg', exchange: '24 exchange', imageBook: 'assets/cover9.jpg',),
  Fictif(type: 'Self-Help', title: 'Self Life For Some dollar', name: 'Milon Henden', imageProfil: 'assets/avatar3.png', exchange: '10 exchange', imageBook: 'assets/cover10.jpg'),
  Fictif(type: 'Self-Help', title: 'Versus For Some Reality IA', name: 'Jordi alif', imageProfil: 'assets/avatar5.jpg', exchange: '4 exchange', imageBook: 'assets/cover2.jpg'),
  Fictif(type: 'Self-Help', title: 'Spider-Monkey For Some Rules', name: 'Moun liod', imageProfil: 'assets/avatar3.png', exchange: '2 exchange', imageBook: 'assets/cover3.jpg'),
  Fictif(type: 'Self-Help', title: 'Your For Some Self Gim', name: 'Fakif Judh', imageProfil: 'assets/avatar5.jpg', exchange: '0 exchange', imageBook: 'assets/cover.jpg'),
  Fictif(type: 'Biographies', title: 'Kilar For Some bee killer', name: 'Notey Kidh', imageProfil: 'assets/avatar5.jpg', exchange: '12 exchange', imageBook: 'assets/cover2.jpg'),
  Fictif(type: 'Romance', title: 'Two Of Us Lastly search', name: 'Lodf jzfh', imageProfil: 'assets/avatar5.jpg', exchange: '15 exchange', imageBook: 'assets/cover5.jpg'),
  Fictif(type: 'Horror', title: 'Open Door For Some Life', name: 'Daof Nibar', imageProfil: 'assets/avatar5.jpg', exchange: '22 exchange', imageBook: 'assets/cover.jpg'),
  Fictif(type: 'Horror', title: 'Dark For Some Side Life', name: 'Lokfh ajnfb', imageProfil: 'assets/avatar5.jpg', exchange: '33 exchange', imageBook: 'assets/cover3.jpg'),
  Fictif(type: 'Romance', title: 'Life For Some Matter Life', name: 'Webdh Lidh', imageProfil: 'assets/avatar5.jpg', exchange: '21 exchange', imageBook: 'assets/cover2.jpg'),
  Fictif(type: 'Historical', title: 'we For Some are in 1925', name: 'Moufa Nuhf', imageProfil: 'assets/avatar5.jpg', exchange: '10 exchange', imageBook: 'assets/cover.jpg'),
  Fictif(type: 'Self-Help', title: 'Solo For Some Ride just here', name: 'Melonch Kidh', imageProfil: 'assets/avatar5.jpg', exchange: '2 exchange', imageBook: 'assets/cover3.jpg'),



];