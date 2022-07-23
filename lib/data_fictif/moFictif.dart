import 'package:ebiblio/exten.dart';
import 'package:flutter/material.dart';

class MoFictif {
  final String title;
  final String type;
  final String name;
  final String exchange;
  final String imageProfil;
  final String imageBook;


  MoFictif({
    required this.title,
    required this.type,
    required this.name,
    required this.exchange,
    required this.imageProfil,
    required this.imageBook

  });
}

List<MoFictif> onMoFictif = [
  MoFictif(type: 'Self-Help', title: 'The Last Night', name: 'Jean-Luc Reichman', imageProfil: 'assets/avatar5.jpg', exchange: '24 exchange', imageBook: 'assets/fio.jpg',),
  MoFictif(type: 'Self-Help', title: 'Self Life', name: 'Milon Henden', imageProfil: 'assets/avatar3.png', exchange: '10 exchange', imageBook: 'assets/fio1.jpg'),
  MoFictif(type: 'Self-Help', title: 'Versus Reality', name: 'Jordi alif', imageProfil: 'assets/avatar5.jpg', exchange: '4 exchange', imageBook: 'assets/fio2.jpg'),
  MoFictif(type: 'Self-Help', title: 'Spider-Monkey', name: 'Moun liod', imageProfil: 'assets/avatar3.png', exchange: '2 exchange', imageBook: 'assets/fio4.jpg'),
  MoFictif(type: 'Self-Help', title: 'Your Self', name: 'Fakif Judh', imageProfil: 'assets/avatar5.jpg', exchange: '0 exchange', imageBook: 'assets/fio5.jpg'),
  MoFictif(type: 'Biographies', title: 'Kilar bee', name: 'Notey Kidh', imageProfil: 'assets/avatar5.jpg', exchange: '12 exchange', imageBook: 'assets/fio6.jpg'),
  MoFictif(type: 'Romance', title: 'Two Of Us', name: 'Lodf jzfh', imageProfil: 'assets/avatar5.jpg', exchange: '15 exchange', imageBook: 'assets/fio7.jpg'),
  MoFictif(type: 'Horror', title: 'Open Door', name: 'Daof Nibar', imageProfil: 'assets/avatar5.jpg', exchange: '22 exchange', imageBook: 'assets/fio8.jpg'),
  MoFictif(type: 'Horror', title: 'Dark Side', name: 'Lokfh ajnfb', imageProfil: 'assets/avatar5.jpg', exchange: '33 exchange', imageBook: 'assets/fio9.jpg'),
  MoFictif(type: 'Romance', title: 'Life Matter', name: 'Webdh Lidh', imageProfil: 'assets/avatar5.jpg', exchange: '21 exchange', imageBook: 'assets/fio.jpg'),
  MoFictif(type: 'Historical', title: 'we are in 1925', name: 'Moufa Nuhf', imageProfil: 'assets/avatar5.jpg', exchange: '10 exchange', imageBook: 'assets/fio4.jpg'),
  MoFictif(type: 'Self-Help', title: 'Solo Ride', name: 'Melonch Kidh', imageProfil: 'assets/avatar5.jpg', exchange: '2 exchange', imageBook: 'assets/fio2.jpg'),



];