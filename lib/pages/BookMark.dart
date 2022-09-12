import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class BookMark extends StatefulWidget {
  const BookMark({Key? key}) : super(key: key);

  @override
  State<BookMark> createState() => _BookMarkState();
}

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

List<String> items = [];
List<bool> bookmark = [];
Map bookmarks = {};


// Future<void> getitems() async {
//
//   await firestore
//       .collection("items")
//       .get()
//       .then((QuerySnapshot querySnapshot) {
//     for (var element in querySnapshot.docs) {
//       bookmarks[element["name"].toString()] = false;
//     }
//   });
//
//   await firestore
//       .collection("users")
//       .add({"email": auth.currentUser!.email, "bookmarks": bookmarks});
//
// }
//
// Future<void> getitmeslogin() async {
//   await firestore
//       .collection("users")
//       .where("email", isEqualTo: auth.currentUser!.email)
//       .get()
//       .then((QuerySnapshot querySnapshot) {
//     for (var element in querySnapshot.docs) {
//       bookmarks = Map.from(element["bookmarks"]);
//     }
//   });
// }
//
// Future<void> update(String email, String item) async {
//   Map<String, bool> bookmark = {};
//
//   await firestore
//       .collection("users")
//       .where("email", isEqualTo: email)
//       .get()
//       .then((QuerySnapshot querySnapshot) {
//     for (var element in querySnapshot.docs) {
//       bookmark = Map.from(element["bookmarks"]);
//       print(bookmark);
//     }
//   });
//
//   for (var element in bookmark.keys) {
//     if (element == item) {
//       bookmark[item] = bookmark[item]! ? false : true;
//     }
//   }
//
//   await firestore
//       .collection("users")
//       .where("email", isEqualTo: email)
//       .get()
//       .then((QuerySnapshot querySnapshot) {
//     for (var element in querySnapshot.docs) {
//       element.reference.update({"bookmarks": bookmark});
//     }
//   });
//
//   await getitmeslogin();
// }

class _BookMarkState extends State<BookMark> {
  @override
  Widget build(BuildContext context) {
    return Container(color:Colors.red);
      // ListView.builder(
      //   itemCount: bookmarks.length,
      //   itemBuilder: (context, index) {
      //     return ListTile(
      //       title: Text(items[index]),
      //       trailing: IconButton(
      //         onPressed: () async {
      //           await func.update(
      //               func.auth.currentUser!.email.toString(), items[index]);
      //           setState(() {
      //             bookmark[index] = !bookmark[index];
      //             print(bookmark[index]);
      //           });
      //         },
      //         icon: bookmark[index]
      //             ? const Icon(Icons.bookmark)
      //             : const Icon(Icons.bookmark_border_outlined),
      //       ),
      //     );
      //   });
  }
}
