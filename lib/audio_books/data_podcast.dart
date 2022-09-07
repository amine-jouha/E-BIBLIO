import 'package:flutter/material.dart';

class allPdItems {
  final  title;
  final  name;
  final  image;
  final  date;
  final  url;


  allPdItems({
    required this.title,
    required this.name,
    required this.image,
    required this.url ,
    required this.date ,

  });

}

List<allPdItems> allPdItemsContent = [
  allPdItems(title: 'Le rendez-vous du MDA avec Victor Wintz', name: "Amine jh, Michel Zerbib", image: "assets/fio1.jpg", url: ["https://samples.audible.com/bk/adfo/000057/bk_adfo_000057_sample.mp3","https://samples.audible.com/bk/gall/001234/bk_gall_001234_sample.mp3", "https://samples.audible.com/bk/odlb/001048/bk_odlb_001048_sample.mp3","https://www.radioj.fr/podcast-player/147927/edition-speciale-attentat-a-elad-en-israel-ilan-klein-directeur-departement-international-mda-israel.mp3","https://www.radioj.fr/wp-content/uploads/2022/04/06h30-le-journal-010522.mp3","https://www.radioj.fr/wp-content/uploads/2022/04/06h00-flash-240422.mp3"], date: ['18/12/2022 à 06:17', '18/12/2022 à 07:20', '19/12/2022 à 10:33', '19/12/2022 à 11:00', '20/12/2022 à 14:30', '21/12/2022 à 15:00']),
  allPdItems(title: 'L\'invité de l\'info Week-end  de Christophe Dard', name: "Amine jh, Alexandra Sénigou", image: "assets/fio2.jpg", url: ["https://samples.audible.com/bk/adfo/000057/bk_adfo_000057_sample.mp3", "https://samples.audible.com/bk/gall/001234/bk_gall_001234_sample.mp3"], date: ['18/12/2022 à 06:17', '18/12/2022 à 07:20']),
  allPdItems(title: 'En direct de Pologne : Dominique Romano, président de Radio J', name: "Alix Motais de Narbonne", image: "assets/fio4.jpg", url: ["https://samples.audible.com/bk/gall/001234/bk_gall_001234_sample.mp3"], date: ['18/12/2022 à 06:17', '18/12/2022 à 07:20']),
  allPdItems(title: 'En route vers les législatives', name: "Ariel Danan, Frédéric Zeitoun", image: "assets/fio5.jpg", url: ["https://samples.audible.com/bk/gall/000229/bk_gall_000229_sample.mp3"], date: ['18/12/2022 à 06:17', '18/12/2022 à 07:20']),
  allPdItems(title: 'Emission spécial seconde fête de Pessah', name: "Frédéric Zeitoun, Victor Wintz", image: "assets/fio6.jpg", url: ["https://samples.audible.com/bk/odlb/001114/bk_odlb_001114_sample.mp3"], date: ['18/12/2022 à 06:17', '18/12/2022 à 07:20']),
  allPdItems(title: 'Le rendez-vous du MDA avec Victor Wintz', name: "Amine jh", image: "assets/fio7.jpg", url: ["https://samples.audible.com/bk/adfr/000142/bk_adfr_000142_sample.mp3"], date: ['18/12/2022 à 06:17', '18/12/2022 à 07:20']),
  allPdItems(title: 'L\'invité de l\'info Week-end  de Christophe Dard', name: "Amine jh", image: "assets/fio8.jpg", url: ["https://samples.audible.com/bk/edth/000209/bk_edth_000209_sample.mp3"], date: ['18/12/2022 à 06:17', '18/12/2022 à 07:20']),
  allPdItems(title: 'L\'histoire des procès', name: "Amine jh", image: "assets/fio9.jpg", url: ["https://samples.audible.com/bk/adfr/000008/bk_adfr_000008_sample.mp3"], date: ['18/12/2022 à 06:17', '18/12/2022 à 07:20']),
  allPdItems(title: 'En route vers les législatives', name: "Amine jh", image: "assets/fio4.jpg", url: ["https://samples.audible.com/bk/edth/000205/bk_edth_000205_sample.mp3"], date: ['18/12/2022 à 06:17', '18/12/2022 à 07:20']),
  allPdItems(title: 'Emission spécial seconde fête de Pessah', name: "Amine jh", image: "assets/fio6.jpg", url: ["https://samples.audible.com/bk/albp/000031/bk_albp_000031_sample.mp3"], date: ['18/12/2022 à 06:17', '18/12/2022 à 07:20']),


];


// import 'package:flutter/material.dart';
//
//
// final List<Map<String, dynamic>> _allListItems = [
//       {
//           "id": 1,
//           "title": "Le rendez-vous du MDA avec Victor Wintz ",
//           // "page": Andy(),
//           "name": "Andy",
//           "image": "assets/pd1.jpg",
//       },
//       {
//           "id": 2,
//           "title": "L'invité de l'info Week-end  de Christophe Dard",
//           // "page": Aragon(),
//           "name": "Aragon",
//           "image": "assets/pd2.jpg",
//       },
//       {
//           "id": 3,
//           "title": "L'histoire des procès",
//           // "page": Bob(),
//           "name": "Bob",
//           "image": "assets/pd3.jpg",
//       },
//       {
//           "id": 4,
//           "title": "En route vers les législatives",
//           // "page": Barbara(),
//           "name": "Barbara",
//           "image": "assets/pd4.jpg",
//       },
//       {
//           "id": 5,
//           "title": "Emission spécial seconde fête de Pessah",
//           // "page": Candy(),
//           "name": "Candy",
//           "image": "assets/pd1.jpg",
//       },
//
// ];